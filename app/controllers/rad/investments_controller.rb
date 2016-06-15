#coding: utf-8
class Rad::InvestmentsController < ApplicationController
  protect_from_forgery except: :rjs_investments_of
  before_action :set_rad_investment, only: [:show, :edit, :update, :destroy]

  # GET /rad/investments
  # GET /rad/investments.json
  def index
    params[:q] = params[:q] ? params[:q] : {}
    @search = Rad::Investment.ransack(params[:q])
    @rad_investments = @search.result.paginate(:page => params[:page])
    #@rad_investments = Rad::Investment.paginate(:page => params[:page])

    Wf::Deployment.deploy(path: 'rad_test.bpmn20.xml', name: 'rad_test_deploy', group_name: 'rad_test_group')
    @deployments = Wf::Deployment.list
    #查询待办事项
    @ntd = Wf::ActInst.find_ntd_by_user(current_user).select { |o| o.is_a?(Rad::Investment) }.uniq.reverse
    #查询已办事项
    @hd = Wf::ActInst.find_hd_by_user(current_user).select { |o| o.is_a?(Rad::Investment) }.uniq.reverse
    #查询办结事项
    @f = Wf::ActInst.find_f_by_user(current_user).select { |o| o.is_a?(Rad::Investment) }.uniq.reverse
  end

  def event_index

  end

  def wf_opinion
    @task = Wf::Task.find params[:task_id]
    render layout: 'form'
  end

  def jw_opinion
    @rad_investment = Rad::Investment.find(params[:id])
    @file_type = params[:file_type]
    render layout: 'form'
  end

  def wf_index
    @tab_idx = params[:tab_idx].blank? ? 0 : params[:tab_idx]
    @ntd = Wf::ActInst.find_ntd_by_user(current_user).uniq.reverse
    #查询已办事项
    @hd = Wf::ActInst.find_hd_by_user(current_user).uniq.reverse
    #查询办结事项
    @f = Wf::ActInst.find_f_by_user(current_user).uniq.reverse

    #待认领工作
    sql = ActiveRecord::Base.connection()
    arr = sql.select_all("SELECT ACT_HI_TASKINST.ID_ as task_id,
                         substring_index(`ACT_HI_IDENTITYLINK`.GROUP_ID_ ,'_',1) as org_code,
                         substring_index(`ACT_HI_IDENTITYLINK`.GROUP_ID_ ,'_',-1) as role_code
                         FROM ACT_HI_TASKINST inner join ACT_HI_IDENTITYLINK on ACT_HI_TASKINST.ID_ = ACT_HI_IDENTITYLINK.TASK_ID_
                         WHERE  ACT_HI_TASKINST.ASSIGNEE_ is null and ACT_HI_IDENTITYLINK.TYPE_='candidate'").to_hash
    task_ids = []
    arr.each do |a|
      if current_user.has_workflow_role(a["org_code"], a["role_code"])
        task_ids << a["task_id"]
      end
    end
    @task = Wf::Task.where("ID_ in (?)", task_ids)
    #@need_to_claim = Wf::ActInst.where("TASK_ID_ in (?)",task_ids).map{|t|t.wf_proc_inst.proc_resource.resource}.select{|o|o.is_a?(Oa::SentDocument)}.uniq
  end

  # GET /rad/investments/1
  # GET /rad/investments/1.json
  def show
  end

  def show_his
    @rad_investment = Rad::Investment.find(params[:id])
  end

  # GET /rad/investments/new
  def new
    if current_org.is_ent?
      @rad_investment = Rad::Investment.new(year: Time.now.year, ent_id: current_org.resource_id)
    else
      @rad_investment = Rad::Investment.new(year: Time.now.year)
    end
    Fdn::FileTemplate.by_resource_type("Rad::Investment").by_template_type('FIR').each do |temp|
      @fir_file = @rad_investment.fir_files.build(:file_template_id => temp.id)
      @fdn_event = @fir_file.build_fdn_event(resource_type: 'Fdn::FileResource')
    end
    Fdn::FileTemplate.by_resource_type("Rad::Investment").by_template_type('SEC').each do |temp|
      @sec_file = @rad_investment.sec_files.build(:file_template_id => temp.id)
      @fdn_event = @sec_file.build_fdn_event(resource_type: 'Fdn::FileResource')
    end
    Fdn::FileTemplate.by_resource_type("Rad::Investment").by_template_type('THR').each do |temp|
      @thr_file = @rad_investment.thr_files.build(:file_template_id => temp.id)
      @fdn_event = @thr_file.build_fdn_event(resource_type: 'Fdn::FileResource')
    end
  end

  # GET /rad/investments/1/edit
  def edit
    @instance = Wf::ProcInst.find_by_resource(@rad_investment)
    @task = Wf::Task.find_by(PROC_INST_ID_: @instance.getId, ASSIGNEE_: current_user.wf_id, END_TIME_: nil)
  end

  # POST /rad/investments
  # POST /rad/investments.json
  def create
    @rad_investment = Rad::Investment.new(rad_investment_params)

    respond_to do |format|
      if @rad_investment.save
        @rad_investment.create_wf_proc_resource(deployment_name: 'rad_test_deploy', variables: {'resource_type' => 'Rad::Investment'})
        format.html { redirect_to edit_rad_investment_path(@rad_investment), notice: '年度投资计划创建成功。' }
        format.json { render :show, status: :created, location: @rad_investment }
      else
        format.html { render :new }
        format.json { render json: @rad_investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rad/investments/1
  # PATCH/PUT /rad/investments/1.json
  def update
    if params[:bs_next]
      @rad_investment.status = 'locked'
    end
    respond_to do |format|
      if @rad_investment.update(rad_investment_params)
        instance = Wf::ProcInst.find_by_resource(@rad_investment)
        task = Wf::Task.find_by(PROC_INST_ID_: instance.getId, ASSIGNEE_: current_user.wf_id, END_TIME_: nil)
        [[params[:option1], '业务角度'], [params[:option2], '经济角度'], [params[:option3], '社会效益'], [params[:option4], '角度四'], [params[:option5], '角度五']].each do |p|
          if !p[0].blank?
            opinion = task.task_opinions.build(opinion: p[0], name: p[1])
            opinion.save
          end
        end
        if params[:bs_next]
          Wf::Task.complete(@rad_investment, current_user, {'allow' => 'true'})
          format.html { redirect_to @rad_investment, notice: '年度投资计划提交成功。' }
          format.json { render :show, status: :ok, location: @rad_investment }
        elsif params[:bs_prev]
          Wf::Task.complete(@rad_investment, current_user, {'allow' => 'false'})
          format.html { redirect_to @rad_investment, notice: '年度投资计划退回成功。' }
          format.json { render :show, status: :ok, location: @rad_investment }
        else
          format.html { redirect_to @rad_investment, notice: '年度投资计划更新成功。' }
          format.json { render :show, status: :ok, location: @rad_investment }
        end
      else
        @instance = Wf::ProcInst.find_by_resource(@rad_investment)
        @task = Wf::Task.find_by(PROC_INST_ID_: @instance.getId, ASSIGNEE_: current_user.wf_id, END_TIME_: nil)
        format.html { render :edit }
        format.json { render json: @rad_investment.errors, status: :unprocessable_entity }
      end
    end
  end

  def jw_update
    @rad_investment = Rad::Investment.find(params[:id])
    respond_to do |format|
      if @rad_investment.update(rad_investment_params)
        format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'rad/investments', :action => :jw_opinions_refresh), {id: @rad_investment.id}, '纪委监察意见创建成功！') }
        #format.html { redirect_to @rad_investment, notice: '年度投资计划更新成功。' }
        format.json { render :show, status: :ok, location: @rad_investment }
      else
        format.html { render :edit }
        format.json { render json: @rad_investment.errors, status: :unprocessable_entity }
      end
    end
  end

  def jw_opinions_refresh
    @rad_investment = Rad::Investment.find(params[:id])
  end

  # DELETE /rad/investments/1
  # DELETE /rad/investments/1.json
  def destroy
    @rad_investment.destroy
    respond_to do |format|
      format.html { redirect_to rad_investments_url, notice: 'Investment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_file
    @rad_investment = params[:id] ? Rad::Investment.find(params[:id]) : Rad::Investment.new
    @the_file = @rad_investment.file_resources.build
    @index = params[:index].to_i
    respond_to do |format|
      format.js
    end
  end

  def add_jw_opinion
    @rad_investment = params[:id] ? Rad::Investment.find(params[:id]) : Rad::Investment.new
    @opinion = @rad_investment.jw_opinions.build(resource_type: 'Rad::Investment')
    @index = params[:index].to_i
    respond_to do |format|
      format.js
    end
  end

  def del_file
    @file_id = params[:id]
    if params[:if_resource]=='yes'
      Fdn::FileResource.delete(params[:id])
    end
    respond_to do |format|
      format.html
    end
  end

  def show_parent
    @rad_investment = Rad::Investment.find(params[:inv_id])
    @accounting = @rad_investment.accounting
    @last_year_accounting = @rad_investment.year_accounting
    @end_last_year_accounting = (@rad_investment.end_last_year_accounting || 0) + (@rad_investment.year_accounting || 0)
    @start_year = @rad_investment.start_year
    @end_year = @rad_investment.end_year
  end

  def rjs_investments_of
    #只显示自己和自己的父子
    #arr = Fdn::Organization.self_group(session[:org_id])
    #new_arr = arr.size > 0 ? arr : Fdn::Organization.all
    if current_org.is_ent?
      render :js => rjs_by_collection(Rad::Investment.by_ent_id(current_org.resource_id), params[:columns], 'investments')
    else
      render :js => rjs_by_collection(Rad::Investment.all, params[:columns], 'investments')
    end
    #render :js => rjs('Fdn::Organization', params[:columns], 'orgs')
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rad_investment
    @rad_investment = Rad::Investment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rad_investment_params
    params.require(:rad_investment).permit! if params[:rad_investment]
  end
end
