#coding: utf-8
class Aae::FinancialStatementsController < ApplicationController
  before_action :set_aae_financial_statement, only: [:show, :edit, :update, :destroy]
  include ApplicationHelper

  # GET /aae/financial_statements
  # GET /aae/financial_statements.json
  def index
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id]
    @org = Fdn::Organization.find @org_id

    @aae_financial_statements = Aae::FinancialStatement.where("ent_id=?", @org.resource_id).order("year desc,month desc").paginate(:per_page => 10, :page => params[:q_page])
  end


  def year_index
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id]
    @org = Fdn::Organization.find @org_id
    @aae_financial_statements = Aae::FinancialStatement.where("ent_id=?", @org.resource_id).where("month='12'").order("year desc,month desc").paginate(:per_page => 10, :page => params[:q_page])
  end

  # GET /aae/financial_statements/1
  # GET /aae/financial_statements/1.json
  def show
  end

  # GET /aae/financial_statements/new
  def new
    @time_code = params[:time_code]
    @aae_financial_statement = Aae::FinancialStatement.new
  end

  # GET /aae/financial_statements/1/edit
  def edit
    if @aae_financial_statement.month =='12'
      @time_code=2
    else
      @time_code=1

    end

  end

  # POST /aae/financial_statements
  # POST /aae/financial_statements.json
  def create
    @aae_financial_statement = Aae::FinancialStatement.new(aae_financial_statement_params)

    respond_to do |format|
      if @aae_financial_statement.save
        format.html { redirect_to edit_aae_financial_statement_path(@aae_financial_statement), notice: 'Financial statement was successfully created.' }
        format.json { render :show, status: :created, location: @aae_financial_statement }
      else
        format.html { render :new }
        format.json { render json: @aae_financial_statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aae/financial_statements/1
  # PATCH/PUT /aae/financial_statements/1.json
  def update
    respond_to do |format|
      if @aae_financial_statement.update_attributes(aae_financial_statement_params)
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '报表创建成功！') }
        format.json { render :show, status: :ok, location: @aae_financial_statement }
      else
        format.html { render :edit }
        format.json { render json: @aae_financial_statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aae/financial_statements/1
  # DELETE /aae/financial_statements/1.json
  def destroy
    @aae_financial_statement.destroy
    respond_to do |format|
      format.html { redirect_to aae_financial_statements_url, notice: 'Financial statement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_record
    @aae_financial_statement = Aae::FinancialStatement.find(params[:id])
    @month = @aae_financial_statement.month
    @org_id = @aae_financial_statement.enterprise.organization.id
    @aae_financial_statement.destroy
    @org = Fdn::Organization.find @org_id
    if @month != 12
      @aae_financial_statements = Aae::FinancialStatement.where("ent_id=?", @org.resource_id).order("year desc,month asc").paginate(:per_page => 10, :page => params[:page])
    else
      @aae_financial_statements = Aae::FinancialStatement.where("ent_id=?", @org.resource_id).where("month='12'").order("year desc,month asc").paginate(:per_page => 10, :page => params[:page])
    end
  end


  def ajax_refresh
    @month_arr= []
    @ent_id = params[:ent_id]
    @year = params[:year]
    @id = params[:id]
    @month_arr = Aae::FinancialStatement.where("ent_id=? and year=? and id !=?", @ent_id, @year, @id).pluck(:month).join(',')
  end

  # 年度财务分析
  def year_analysis
    @org_name = params[:org_name]
    if params[:q].blank?
      @year = Time.now.year.to_s
      @month = 12
      @ent_id= current_org.is_ent? ? current_org.resource_id : ''
    else
      @year = !params[:q][:year_eq].blank? ? params[:q][:year_eq] : Time.now.year.to_s
      @month = 12
      @ent_id = params[:q][:ent_id_eq].blank? ? (current_org.is_ent? ? current_org.resource_id : '') : params[:q][:ent_id_eq]
    end
    if !@ent_id.blank?
      @name = Fdn::Enterprise.find(@ent_id).name
      @financial_statement = Aae::FinancialStatement.by_year(@year).by_month(@month).by_ent_id(@ent_id).first
      @indicator = @financial_statement.nil? ? nil : @financial_statement.indicator
      @financial_statement_last_year = Aae::FinancialStatement.by_year(@year.to_i-1).by_month(@month).by_ent_id(@ent_id).first
      @indicator_last_year = @financial_statement_last_year.nil? ? nil : @financial_statement_last_year.indicator
    else
      @name = ''
      @financial_statement = nil
    end
    @name = (params[:q].blank? || params[:q][:name_cont].blank?) ? @name : params[:q][:name_cont]
    @search = Aae::FinancialStatement.search(params[:q])
    @aae_financial_statement = @search.result
  end

  def financial_analysis
    @org_name = params[:org_name]
    params[:q] = !params[:q].blank? ? params[:q] : {}
    @option = params[:q][:zzz_option] || '1'
    if !params[:q][:organization_id_eq].blank?
      @name = Fdn::Organization.find(params[:q][:organization_id_eq]).name
      @ent_id = Fdn::Organization.find(params[:q][:organization_id_eq]).resource_id
    else
      if current_org.is_ent?
        @ent_id = current_org.resource_id
        @name = current_org.name
      else
        @name = ''
        @ent_id = nil
      end
    end
    @name = !@name.blank? ? @name : params[:q][:name_cont]
    @search = Fdn::Enterprise.search(params[:q])
    @search_ent = @search.result
    case @option
      when '1'
        @financial_statements = Aae::FinancialStatement.by_ent_id(@ent_id).order("year DESC, month DESC")
      when '2'
        @financial_statements = Aae::FinancialStatement.by_ent_id(@ent_id).by_quarter.order("year DESC, month DESC")
      when '3'
        @financial_statements = Aae::FinancialStatement.by_ent_id(@ent_id).by_month(12).order("year DESC, month DESC")
    end

    #@financial_statements = Aae::FinancialStatement.by_ent_id(@ent_id).limit(5).order("year DESC, month DESC")
    @x_axis = []
    @financial_statements.each do |fs|
      if !fs.blank?
        @x_axis << fs.year_month_date
      end
    end
    bar_part(@ent_id, @financial_statements, @x_axis, '1', '流动比率')
    bar_part(@ent_id, @financial_statements, @x_axis, '3', '资产负债率')
    bar_part(@ent_id, @financial_statements, @x_axis, '25', '销售净利率')
    bar_part(@ent_id, @financial_statements, @x_axis, '28', '净资产收益率')
    bar_part(@ent_id, @financial_statements, @x_axis, '15', '存货周转率')
    bar_part(@ent_id, @financial_statements, @x_axis, '23', '总资产周转率')
  end

  def financial_warning
    @org_name = params[:org_name]
    @orgs = []
    if params[:q].blank?
      @year = Time.now.year.to_s
      @month = Time.now.month.to_s
      #@month = 12
    else
      @year = !params[:q][:year_eq].blank? ? params[:q][:year_eq] : Time.now.year.to_s
      @month = !params[:q][:month_eq].blank? ? params[:q][:month_eq] : Time.now.month.to_s
      #@month = 12
      if params[:q][:enterprise_organization_id_eq].blank?
        if current_org.is_ent?
          @orgs << current_org
          @name = current_org.name
        end
        current_org.with_hierarchy.all_descendants.each do |o|
          #@orgs.insert(0,current_org)
          @orgs << o
        end
      else
        @search_org = Fdn::Organization.where(resource_type: 'Fdn::Enterprise', resource_id: params[:q][:enterprise_organization_id_eq]).first
        @orgs << @search_org
        #@search_org.with_hierarchy.all_descendants.each do |o|
        #  @orgs << o
        #end
      end
    end

    #if !params[:org_id].blank?
    #  org = Fdn::Organization.find(params[:org_id]).with_hierarchy(@hierarchy_id,@eff_time)
    #else
    #  org = Fdn::Organization.find(session[:org_id]).with_hierarchy(@hierarchy_id,@eff_time)
    #end
    #
    #@financial_statement = Aae::FinancialStatement.by_year(@year).by_month(@month).by_ent_id(@ent_id).first
    #@indicator = @financial_statement.nil? ? nil : @financial_statement.indicator
    #@financial_statement_last_year = Aae::FinancialStatement.by_year(@year.to_i-1).by_month(@month).by_ent_id(@ent_id).first
    #@indicator_last_year = @financial_statement_last_year.nil? ? nil : @financial_statement_last_year.indicator
    @search = Aae::FinancialStatement.search(params[:q])
    @aae_financial_statement = @search.result
  end

  # 月度财务分析
  def month_analysis
    @org_name = params[:org_name]
    if params[:q].blank?
      @year = Time.now.year.to_s
      @month = Time.now.month.to_s
      @ent_id = current_org.is_ent? ? current_org.resource_id : ''
    else
      @year = !params[:q][:year_eq].blank? ? params[:q][:year_eq] : Time.now.year.to_s
      @month = !params[:q][:month_eq].blank? ? params[:q][:month_eq] : Time.now.month.to_s
      @ent_id = params[:q][:ent_id_eq].blank? ? (current_org.is_ent? ? current_org.resource_id : '') : params[:q][:ent_id_eq]
    end
    if !@ent_id.blank?
      @name = Fdn::Enterprise.find(@ent_id).name
      @financial_statement = Aae::FinancialStatement.by_year(@year).by_month(@month).by_ent_id(@ent_id).first
      @indicator = @financial_statement.nil? ? nil : @financial_statement.indicator
      @financial_statement_last_year = Aae::FinancialStatement.by_year(@year.to_i-1).by_month(@month).by_ent_id(@ent_id).first
      @indicator_last_year = @financial_statement_last_year.nil? ? nil : @financial_statement_last_year.indicator
      if @month != 1
        @financial_statement_last_month = Aae::FinancialStatement.by_year(@year).by_month(@month.to_i-1).by_ent_id(@ent_id).first
      else
        @financial_statement_last_month = Aae::FinancialStatement.by_year(@year.to_i-1).by_month(12).by_ent_id(@ent_id).first
      end
      @indicator_last_month = @financial_statement_last_year.nil? ? nil : @financial_statement_last_year.indicator
    else
      @name = ''
      @financial_statement = nil
    end
    @name = (params[:q].blank? || params[:q][:name_cont].blank?) ? @name : params[:q][:name_cont]
    @search = Aae::FinancialStatement.search(params[:q])
    @aae_financial_statement = @search.result
  end

  def short_term_debt_paying
    line_part(params[:year], params[:month], params[:ent_id], '1', '流动比率')
    #max = Aae::Indicator.max_attr(1, true)
    speedometer_part(params[:year], params[:month], params[:ent_id], 1, '流动比率',
                     [[0, 0.5, '#ff0000'],
                      [0.5, 1, '#fc6767'],
                      [1, 1.5, '#ffab00'],
                      [1.5, 4, '#afff00'],
                      [4, 5, '#00ff00']], '')
    #speedometer_part1(params[:year], params[:month], params[:ent_id], 1, '流动比率', 1.5, 100, '', 5)
    line_part(params[:year], params[:month], params[:ent_id], '2', '速动比率')
    #line_part2(params[:year], params[:month], params[:ent_id], '2', '速动比率')
    #max = Aae::Indicator.max_attr(2, true)
    speedometer_part(params[:year], params[:month], params[:ent_id], 2, '速动比率',
                     [[0, 0.5, '#ff0000'],
                      [0.5, 0.8, '#fc6767'],
                      [0.8, 1.5, '#ffab00'],
                      [1.5, 3, '#afff00'],
                      [3, 5, '#00ff00']], '')
    #speedometer_part2(params[:year], params[:month], params[:ent_id], 2, '速动比率', 0.8, 100, '', 10)
    render :layout => 'form'
  end


  def long_term_debt_paying
    line_part(params[:year], params[:month], params[:ent_id], '3', '资产负债率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 3, '资产负债率',
                     [[0, 25, '#00ff00'],
                      [25, 50, '#afff00'],
                      [50, 70, '#ffab00'],
                      [70, 85, '#fc6767'],
                      [85, 100, '#ff0000']], '')

    line_part(params[:year], params[:month], params[:ent_id], '4', '权益比率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 4, '权益比率',
                     [[0, 0.15, '#ff0000'],
                      [0.15, 0.3, '#fc6767'],
                      [0.3, 0.5, '#ffab00'],
                      [0.5, 0.75, '#afff00'],
                      [0.75, 1, '#00ff00']], '')

    line_part(params[:year], params[:month], params[:ent_id], '5', '权益乘数')
    speedometer_part(params[:year], params[:month], params[:ent_id], 5, '权益乘数',
                     [[0, 0.15, '#00ff00'],
                      [0.15, 0.3, '#afff00'],
                      [0.3, 0.5, '#ffab00'],
                      [0.5, 0.75, '#fc6767'],
                      [0.75, 1, '#ff0000']], '')

    line_part(params[:year], params[:month], params[:ent_id], '6', '产权比率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 6, '产权比率',
                     [[0, 120, '#00ff00'],
                      [120, 140, '#afff00'],
                      [140, 180, '#ffab00'],
                      [180, 300, '#fc6767'],
                      [300, 330, '#ff0000']], '%')

    line_part(params[:year], params[:month], params[:ent_id], '7', '有形净资产负债率')

    line_part(params[:year], params[:month], params[:ent_id], '9', '利息保障倍数')
    #speedometer_part(params[:year], params[:month], params[:ent_id], 9, '利息保障倍数',
    #                  [[0,1,'#DDDF0D'],
    #                   [1,5,'#22AC3C'],
    #                   [5,10,'#DF5353']], '')

    #line_part3(params[:year], params[:month], params[:ent_id], '3', '资产负债率')
    #max = Aae::Indicator.max_attr(3, true)
    #speedometer_part3(params[:year], params[:month], params[:ent_id], 3, '资产负债率', 50, 100, '%', 100)
    #line_part4(params[:year], params[:month], params[:ent_id], '4', '权益比率')
    #speedometer_part4(params[:year], params[:month], params[:ent_id], 4, '权益比率', 1, 100, '', 1)
    #line_part5(params[:year], params[:month], params[:ent_id], '5', '权益乘数')
    #line_part6(params[:year], params[:month], params[:ent_id], '6', '产权比率')
    #speedometer_part6(params[:year], params[:month], params[:ent_id], 6, '产权比率', 120, 100, '%', 300)
    #line_part7(params[:year], params[:month], params[:ent_id], '7', '有形净资产负债率')
    #line_part9(params[:year], params[:month], params[:ent_id], '9', '利息保障倍数')
    #max = Aae::Indicator.max_attr(9, true)
    #speedometer_part9(params[:year], params[:month], params[:ent_id], 9, '利息保障倍数', 1, max[0], '/', max[1])

    #x_axis = %w{资产负债率 权益比率 权益乘数 产权比率 有形净资产负债率 利息保障倍数}
    #spiderweb_part(Aae::FinancialStatement::LONG_HAS_CHART, params[:year], params[:month], params[:ent_id], x_axis, '长期偿债能力', params[:width])
    #@name='long_spider'
    render :layout => 'form'
  end

  def assess_of_economic
    line_part(params[:year], params[:month], params[:ent_id], '11', '应收账款周转率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 11, '应收账款周转率',
                     [[0, 0.5, '#ff0000'],
                      [0.5, 1, '#fc6767'],
                      [1, 3, '#ffab00'],
                      [3, 5, '#afff00'],
                      [5, 8, '#00ff00']], '')

    line_part(params[:year], params[:month], params[:ent_id], '14', '应收账款周转天数')
    speedometer_part(params[:year], params[:month], params[:ent_id], 14, '应收账款周转天数',
                     [[0, 100, '#00ff00'],
                      [100, 150, '#afff00'],
                      [150, 250, '#ffab00'],
                      [250, 350, '#fc6767'],
                      [350, 500, '#ff0000']], '')

    line_part(params[:year], params[:month], params[:ent_id], '15', '存货周转率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 15, '存货周转率',
                     [[0, 0.5, '#ff0000'],
                      [0.5, 1, '#fc6767'],
                      [1, 3, '#ffab00'],
                      [3, 5, '#afff00'],
                      [5, 8, '#00ff00']], '')

    line_part(params[:year], params[:month], params[:ent_id], '18', '存货周转天数')
    speedometer_part(params[:year], params[:month], params[:ent_id], 18, '存货周转天数',
                     [[0, 100, '#00ff00'],
                      [100, 150, '#afff00'],
                      [150, 250, '#ffab00'],
                      [250, 350, '#fc6767'],
                      [350, 500, '#ff0000']], '')

    line_part(params[:year], params[:month], params[:ent_id], '19', '流动资产周转率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 19, '流动资产周转率',
                     [[0, 0.5, '#ff0000'],
                      [0.5, 1, '#fc6767'],
                      [1, 3, '#ffab00'],
                      [3, 5, '#afff00'],
                      [5, 8, '#00ff00']], '')

    line_part(params[:year], params[:month], params[:ent_id], '21', '流动资产周转天数')
    speedometer_part(params[:year], params[:month], params[:ent_id], 21, '流动资产周转天数',
                     [[0, 90, '#00ff00'],
                      [90, 180, '#afff00'],
                      [180, 270, '#ffab00'],
                      [270, 360, '#fc6767'],
                      [360, 450, '#ff0000']], '')

    line_part(params[:year], params[:month], params[:ent_id], '22', '固定资产收入率')

    line_part(params[:year], params[:month], params[:ent_id], '23', '总资产周转率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 23, '总资产周转率',
                     [[0, 0.8, '#ff0000'],
                      [0.8, 1.2, '#fc6767'],
                      [1.2, 1.5, '#ffab00'],
                      [1.5, 4, '#afff00'],
                      [4, 8, '#00ff00']], '')

    line_part(params[:year], params[:month], params[:ent_id], '24', '营业周期')
    speedometer_part(params[:year], params[:month], params[:ent_id], 24, '营业周期',
                     [[0, 200, '#00ff00'],
                      [200, 290, '#afff00'],
                      [290, 380, '#ffab00'],
                      [380, 470, '#fc6767'],
                      [470, 560, '#ff0000']], '')

    #line_part11(params[:year], params[:month], params[:ent_id], '11', '应收账款周转率')
    #max = Aae::Indicator.max_attr(11, true)
    #speedometer_part11(params[:year], params[:month], params[:ent_id], 11, '应收账款周转率', 3, max[0], '', 8)
    #line_part14(params[:year], params[:month], params[:ent_id], '14', '应收账款周转天数')
    #speedometer_part14(params[:year], params[:month], params[:ent_id], 14, '应收账款周转天数', 3, max[0], '', 1000)
    #line_part19(params[:year], params[:month], params[:ent_id], '19', '流动资产周转率')
    #speedometer_part19(params[:year], params[:month], params[:ent_id], 19, '流动资产周转率', 3, max[0], '', 8)
    #line_part21(params[:year], params[:month], params[:ent_id], '21', '流动资产周转天数')
    #speedometer_part21(params[:year], params[:month], params[:ent_id], 21, '流动资产周转天数', 3, max[0], '', 1000)
    #line_part23(params[:year], params[:month], params[:ent_id], '23', '总资产周转率')
    #
    #speedometer_part23(params[:year], params[:month], params[:ent_id], 23, '总资产周转率', 3, max[0], '', 8)
    #line_part24(params[:year], params[:month], params[:ent_id], '24', '营业周期')
    #
    #speedometer_part24(params[:year], params[:month], params[:ent_id], 24, '营业周期', 3, max[0], '', 1000)
    #x_axis = %w{应收账款周转率 应收账款周转天数 流动资产周转率 流动资产周转天数 总资产周转率 营业周期}
    #spiderweb_part(Aae::FinancialStatement::ASSESS_HAS_CHART, params[:year], params[:month], params[:ent_id], x_axis, '经济业绩考核', params[:width])
    #@name='assess_spider'

    render :layout => 'form'
  end

  def month_economic_situation
    line_part(params[:year], params[:month], params[:ent_id], '25', '销售净利率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 25, '销售净利率',
                     [[-100, -50, '#ff0000'],
                      [-50, 0, '#fc6767'],
                      [0, 20, '#ffab00'],
                      [20, 60, '#afff00'],
                      [60, 100, '#00ff00']], '')
    line_part(params[:year], params[:month], params[:ent_id], '26', '资产净利率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 26, '资产净利率',
                     [[-100, -50, '#ff0000'],
                      [-50, 0, '#fc6767'],
                      [0, 20, '#ffab00'],
                      [20, 60, '#afff00'],
                      [60, 100, '#00ff00']], '')
    line_part(params[:year], params[:month], params[:ent_id], '27', '资本金净利率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 27, '资本金净利率',
                     [[-100, -50, '#ff0000'],
                      [-50, 0, '#fc6767'],
                      [0, 20, '#ffab00'],
                      [20, 60, '#afff00'],
                      [60, 100, '#00ff00']], '')
    line_part(params[:year], params[:month], params[:ent_id], '28', '净资收益率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 28, '净资收益率',
                     [[-100, -20, '#ff0000'],
                      [-20, 0, '#fc6767'],
                      [0, 10, '#ffab00'],
                      [10, 20, '#afff00'],
                      [20, 30, '#00ff00']], '')
    line_part(params[:year], params[:month], params[:ent_id], '29', '盈余现金保障倍数')
    speedometer_part(params[:year], params[:month], params[:ent_id], 29, '盈余现金保障倍数',
                     [[-20, -10, '#ff0000'],
                      [-10, 0, '#fc6767'],
                      [0, 5, '#ffab00'],
                      [5, 7, '#afff00'],
                      [7, 20, '#00ff00']], '')

    line_part(params[:year], params[:month], params[:ent_id], '30', '资本保值增值率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 30, '资本保值增值率',
                     [[0, 1, '#ff0000'],
                      [1, 1, '#ffab00'],
                      [1, 2, '#00ff00']], '')
    #line_part25(params[:year], params[:month], params[:ent_id], '25', '销售净利率')
    #speedometer_part25(params[:year], params[:month], params[:ent_id], 25, '销售净利率', 3, 0, '', 100)
    #line_part26(params[:year], params[:month], params[:ent_id], '26', '资产净利率')
    #speedometer_part26(params[:year], params[:month], params[:ent_id], 26, '资产净利率', 3, 0, '', 100)
    #line_part27(params[:year], params[:month], params[:ent_id], '27', '资本金净利率')
    #speedometer_part27(params[:year], params[:month], params[:ent_id], 27, '资本金净利率', 3, 0, '', 100)
    #line_part28(params[:year], params[:month], params[:ent_id], '28', '净资收益率')
    #speedometer_part28(params[:year], params[:month], params[:ent_id], 28, '净资收益率', 3, 0, '', 30)
    #line_part29(params[:year], params[:month], params[:ent_id], '29', '盈余现金保障倍数')
    #speedometer_part29(params[:year], params[:month], params[:ent_id], 29, '盈余现金保障倍数', 3, 0, '', 20)
    #line_part30(params[:year], params[:month], params[:ent_id], '30', '资本保值增值率')
    #speedometer_part30(params[:year], params[:month], params[:ent_id], 30, '资本保值增值率', 3, 0, '', 20)

    render :layout => 'form'
  end

  def month_development_ability
    #line_part43(params[:year], params[:month], params[:ent_id], '43', '资本积累率')
    #speedometer_part43(params[:year], params[:month], params[:ent_id], 43, '资本积累率', 3, 0, '', 50)

    line_part(params[:year], params[:month], params[:ent_id], '43', '资本积累率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 43, '资本积累率',
                     [[0, 3, '#ff0000'],
                      [3, 5, '#fc6767'],
                      [5, 10, '#ffab00'],
                      [10, 20, '#afff00'],
                      [20, 50, '#00ff00']], '')

    render :layout => 'form'
  end

  def month_cash_flow_structure
    line_part(params[:year], params[:month], params[:ent_id], '38', '现金到期债务比')
    speedometer_part(params[:year], params[:month], params[:ent_id], 38, '现金到期债务比',
                     [[0, 0.5, '#ff0000'],
                      [0.5, 1, '#fc6767'],
                      [1, 1.5, '#ffab00'],
                      [1.5, 5, '#afff00'],
                      [5, 10, '#00ff00']], '')
    line_part(params[:year], params[:month], params[:ent_id], '39', '现金流动负债比')
    speedometer_part(params[:year], params[:month], params[:ent_id], 39, '现金流动负债比',
                     [[-10, 0.5, '#ff0000'],
                      [0.5, 1.5, '#fc6767'],
                      [1.5, 3, '#ffab00'],
                      [3, 5, '#afff00'],
                      [5, 10, '#00ff00']], '')
    line_part(params[:year], params[:month], params[:ent_id], '40', '现金债务总额比')
    speedometer_part(params[:year], params[:month], params[:ent_id], 40, '现金债务总额比',
                     [[-10, -5, '#ff0000'],
                      [-5, 0, '#fc6767'],
                      [0, 0.25, '#ffab00'],
                      [0.25, 2, '#afff00'],
                      [2, 10, '#00ff00']], '')
    line_part(params[:year], params[:month], params[:ent_id], '41', '销售现金比率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 41, '销售现金比率',
                     [[0, 0.03, '#ff0000'],
                      [0.03, 0.25, '#fc6767'],
                      [0.25, 1, '#ffab00'],
                      [1, 4, '#afff00'],
                      [4, 10, '#00ff00']], '')
    line_part(params[:year], params[:month], params[:ent_id], '42', '全部资产现金回收率')
    speedometer_part(params[:year], params[:month], params[:ent_id], 42, '全部资产现金回收率',
                     [[-10, 0, '#ff0000'],
                      [0, 2, '#fc6767'],
                      [2, 6, '#ffab00'],
                      [6, 12, '#afff00'],
                      [12, 40, '#00ff00']], '')

    #line_part38(params[:year], params[:month], params[:ent_id], '38', '现金到期债务比')
    #speedometer_part38(params[:year], params[:month], params[:ent_id], 38, '现金到期债务比', 3, 0, '', 20)
    #line_part39(params[:year], params[:month], params[:ent_id], '39', '现金流动负债比')
    #speedometer_part39(params[:year], params[:month], params[:ent_id], 39, '现金流动负债比', 3, 0, '', 10)
    #line_part40(params[:year], params[:month], params[:ent_id], '40', '现金债务总额比')
    #speedometer_part40(params[:year], params[:month], params[:ent_id], 40, '现金债务总额比', 3, 0, '', 10)
    #line_part41(params[:year], params[:month], params[:ent_id], '41', '销售现金比率')
    #speedometer_part41(params[:year], params[:month], params[:ent_id], 41, '销售现金比率', 3, 0, '', 10)
    #line_part42(params[:year], params[:month], params[:ent_id], '42', '全部资产现金回收率')
    #speedometer_part42(params[:year], params[:month], params[:ent_id], 42, '全部资产现金回收率', 3, 0, '', 50)
    render :layout => 'form'
  end


  def month_detail_refresh
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id]
    @org = Fdn::Organization.find @org_id
    if @org.is_ent?
      @aae_financial_statements = Aae::FinancialStatement.where("ent_id=?", @org.resource_id).order("year desc,month asc").paginate(:per_page => 10, :page => params[:page])
    else
      @aae_financial_statements = []
    end
  end

  def year_detail_refresh
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id]
    @org = Fdn::Organization.find @org_id
    if @org.is_ent?
      @aae_financial_statements = Aae::FinancialStatement.where("ent_id=? and month='12'", @org.resource_id).order("year desc,month asc").paginate(:per_page => 10, :page => params[:page])
    else
      @aae_financial_statements = []
    end
  end


  private
  #线性图
  def line_part(year=Time.now.year, month=Time.now.month, ent_id, attr_seq, attr_name)
    year = year.to_i if year.is_a?(String)
    month = month.to_i if month.is_a?(String)
    if !ent_id.blank?
      ent_name = Fdn::Enterprise.find(ent_id).name
    else
      ent_name = nil
    end
    arr = []
    #由年月组成的数组循环， 获得财务数据
    years_months_array(year, month).each do |a|
      fs = Aae::FinancialStatement.by_year(a[0]).by_month(a[1]).by_ent_id(ent_id).first
      if fs.blank? || fs.indicator.blank?
        arr << 0
      else
        eval("arr << format('%.2f',fs.indicator.indicator_attr#{attr_seq}).to_f")
      end
    end
    @h = {"name" => ent_name, "data" => arr}
    #动态执行
    eval("@attr#{attr_seq} = chart_line([@h], months_array(month+1, 12), \"#{attr_name}\", 400, 200, '月份', '比例')")
    #图表的id
    eval("@name#{attr_seq} = 'attr#{attr_seq}'")
  end

  def bar_part(ent_id, financial_statements, x_axis, attr_seq, attr_name)
    if !ent_id.blank?
      ent_name = Fdn::Enterprise.find(ent_id).name
    else
      ent_name = nil
    end
    #数据集
    arr = []
    #找出该企业历史财务数据
    financial_statements.take(6).each do |fs|
      if fs.blank? || fs.indicator.blank?
        arr << 0
      else
        eval("arr << format('%.2f',fs.indicator.indicator_attr#{attr_seq}).to_f")
      end
    end

    @h = {"name" => ent_name, "data" => arr}
    #动态执行
    eval("@attr#{attr_seq} = chart_bar([@h], x_axis.take(6), \"#{attr_name}\", 400, 300, '时间', '')")
    #图表的id
    eval("@name#{attr_seq} = 'attr#{attr_seq}'")
  end

  #仪表盘图
  def speedometer_part(year, month, ent_id, attr_seq, attr_name, y_axis_arr, y_title='/', direct=true)
    if !ent_id.blank?
      ent_name = Fdn::Enterprise.find(ent_id).name
    else
      ent_name = nil
    end
    fs = Aae::FinancialStatement.by_year(year).by_month(month).by_ent_id(ent_id).first
    indicator_value = fs.blank? ? 0 : eval("fs.indicator.indicator_attr#{attr_seq}")
    data = {name: ent_name,
            data: indicator_value,
            tooltip: {
                valueSuffix: (y_title=="/" ? "" : y_title)
            }
    }

    #图中分段显示以及每段颜色
    y_axis = []
    #如果数值不在区间，则扩大区间范围
    if y_axis_arr.first[0] > indicator_value
      y_axis << {from: indicator_value, to: y_axis_arr.first[0], color: y_axis_arr.first[2]}
    end
    y_axis_arr.each do |y|
      y_axis << {from: y[0], to: y[1], color: y[2]}
    end
    #如果数值不在区间，则扩大区间范围
    if y_axis_arr.last[1] < indicator_value
      y_axis << {from: y_axis_arr.last[1], to: indicator_value, color: y_axis_arr.last[2]}
    end
    title = "#{attr_name}评价"
    eval("@speed#{attr_seq} = speedometer(data, y_axis, y_title, title, 400, y_axis.first[:from], y_axis.last[:to])")
    eval("@speed_name#{attr_seq}='speed#{attr_seq}'")

  end

  #蛛网图
  def spiderweb_part(seq_block, year, month, ent_id, x_axis, title, width)
    arr = []
    fs = Aae::FinancialStatement.by_year(year).by_month(month).by_ent_id(ent_id).first
    if fs.blank?
      arr << 0
    else
      #将那些做成线性图的属性取出来
      seq_block.each do |i|
        array = eval("Aae::Indicator.max_attr(#{i}, false, #{fs.id})")
        #array[0]是最好的，array[1]判断是否反比
        if array[1]
          eval("arr << format('%.2f',fs.indicator.indicator_attr#{i}/#{array[0]}).to_f")
        else
          eval("arr << format('%.2f',#{array[0]}/fs.indicator.indicator_attr#{i}).to_f")
        end

      end
    end

    data = {name: Fdn::Enterprise.find(ent_id).name,
            data: arr,
            pointPlacement: 'on'
    }
    @attr = chart_spiderweb(data, x_axis, title, width)
  end

  def months_array(from, length=12)
    arr = []
    length.times do |i|
      month = (from+i)
      arr << (month%12==0 ? 12 : (month%12))
    end
    arr
  end

  #返回现在起到之前的年月数组·［...[2013,11],[2013,12],[2014,1]］
  def years_months_array(year, month, length=12)
    arr = []
    time = Time.mktime(year, month)
    length.times do |i|
      arr << [(time-i.months).year, (time-i.months).month]
    end
    arr.reverse!
    arr
  end


  # Use callbacks to share common setup or constraints between actions.
  def set_aae_financial_statement
    @aae_financial_statement = Aae::FinancialStatement.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def aae_financial_statement_params
    params.require(:aae_financial_statement).permit! if params[:aae_financial_statement]
  end
end
