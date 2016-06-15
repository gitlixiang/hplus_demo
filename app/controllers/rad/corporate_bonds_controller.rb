#coding: utf-8
class Rad::CorporateBondsController < ApplicationController
  before_action :set_rad_corporate_bond, only: [:show, :edit, :update, :destroy, :show_analysis]

  # GET /rad/corporate_bonds
  # GET /rad/corporate_bonds.json
  def index
    #@rad_corporate_bonds = Rad::CorporateBond.all
    #params[:q] = params[:q] ? params[:q] : {}
    #@search = Rad::CorporateBond.ransack(params[:q])
    #@rad_corporate_bonds = @search.result.paginate(:page => params[:page])
    #@rad_corporate_bonds = Rad::Investment.paginate(:page => params[:page])

    Wf::Deployment.deploy(path: 'demo_act_2.bpmn20.xml', name: 'demo_act_2', group_name: 'demo_act_2')
    Wf::Deployment.deploy(path: 'demo_act.bpmn20.xml', name: 'demo_act', group_name: 'demo_act')
    #@deployments = Wf::Deployment.list
    #查询待办事项
    @ntd = Wf::ActInst.find_ntd_by_user(current_user).select { |o| o.is_a?(Rad::CorporateBond) }.uniq.reverse
    #查询已办事项
    @hd = Wf::ActInst.find_hd_by_user(current_user).select { |o| o.is_a?(Rad::CorporateBond) }.uniq.reverse
    #查询办结事项
    @f = Wf::ActInst.find_f_by_user(current_user).select { |o| o.is_a?(Rad::CorporateBond) }.uniq.reverse
  end

  def search_index
    params[:q] = params[:q] ? params[:q] : {id_eq: 0}
    @search = Rad::CorporateBond.ransack(params[:q])
    search_ids = Wf::ActInst.find_f.select { |o| o.is_a?(Rad::CorporateBond) }.uniq.reverse.map(&:id)
    @rad_corporate_bonds = @search.result.by_ids(search_ids).paginate(:page => params[:page])
  end

  def export_list
    if File.exist?(Hr::EntTalent::EXPORT_PATH)
      FileUtils.rm_r(Hr::EntTalent::EXPORT_PATH)
      Dir.mkdir(Hr::EntTalent::EXPORT_PATH)
    else
      Dir.mkdir(Hr::EntTalent::EXPORT_PATH)
    end
    params[:q] = params[:q] ? params[:q] : {id_eq: 0}
    @search = Rad::CorporateBond.ransack(params[:q])
    search_ids = Wf::ActInst.find_f.select { |o| o.is_a?(Rad::CorporateBond) }.uniq.reverse.map(&:id)
    @rad_corporate_bonds = @search.result.by_ids(search_ids).paginate(:page => params[:page])
    Spreadsheet.client_encoding = "UTF-8"
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    sheet.name = '企业债务情况'
    sheet.row(0).push "企业债务情况"
    sheet.merge_cells(0, 0, 0, 10)
    sheet.row(1)[0] = "企业名称"
    sheet.row(1)[1] = "债务人"
    sheet.row(1)[2] = "借债日期"
    sheet.row(1)[3] = "债券种类"
    sheet.row(1)[4] = "债务总额(万元)"
    sheet.row(1)[5] = "已还债务(万元)"
    sheet.row(1)[6] = "已付利息(万元)"
    sheet.row(1)[7] = "债务资金投向"
    sheet.row(1)[8] = "还款期限"
    sheet.row(1)[9] = "担保情况"
    sheet.row(1)[10] = "承销机构"
    i = 2
    @rad_corporate_bonds.each do |m|
      sheet.row(i)[0] = m.ent_name
      sheet.row(i)[1] = m.bond_name
      sheet.row(i)[2] = m.bond_date
      sheet.row(i)[3] = m.bond_type
      sheet.row(i)[4] = m.bond_total
      sheet.row(i)[5] = m.repay_money
      sheet.row(i)[6] = m.repay_interest
      sheet.row(i)[7] = m.used
      sheet.row(i)[8] = m.repayments_date
      sheet.row(i)[9] = m.guarantee_info
      sheet.row(i)[10] = m.cooperation_agency
      i += 1
    end
    path = "#{Hr::EntTalent::EXPORT_PATH}/企业债务情况.xls"
    book.write path
    send_file path
  end

  def show_analysis
    @repay_all = []
    @repays = @rad_corporate_bond.rad_repayments.order('repay_date')
    @repays.map { |r| @repay_all << r.count_repayments }
  end

  def analysis_index
    params[:q] = params[:q] ? params[:q] : {}
    @search = Rad::CorporateBond.ransack(params[:q])
    search_ids = Wf::ActInst.find_f.select { |o| o.is_a?(Rad::CorporateBond) }.uniq.reverse.map(&:id)
    @rad_corporate_bond_fn = @search.result.by_ids(search_ids)
    @rad_corporate_bond_all = @search.result
    #审批情况
    @fn_legend = ['已审批', '未审批']
    @fn_data = [{value: @rad_corporate_bond_fn.size, name: '已审批'}, {value: @rad_corporate_bond_all.size-@rad_corporate_bond_fn.size, name: '未审批'}]
    #@fn_data = @fn_data.to_json

    #发债类型情况
    @type_legend = Rad::CorporateBond::BOND_TYPE.map(&:first)
    @type_data = []
    @type_legend.each do |bond_type|
      @type_data << {value: @rad_corporate_bond_all.by_bond_type(bond_type).size, name: bond_type}
    end
    #@type_data = @type_data.to_json

    #发债资金投向情况
    @used_legend =Rad::CorporateBond::USED.map(&:first)
    @used_data = []
    @used_legend.each do |used|
      @used_data << @rad_corporate_bond_all.by_used(used).size
    end

    #发债额/还款情况
    @bond_total = @rad_corporate_bond_fn.sum('bond_total')
    @repay_money = 0
    @rad_corporate_bond_all.map { |cor| @repay_money +=cor.repay_money }
  end

  # GET /rad/corporate_bonds/1
  # GET /rad/corporate_bonds/1.json
  def show
  end

  # GET /rad/corporate_bonds/new
  def new
    if current_org.resource_type == "Fdn::Enterprise"
      @rad_corporate_bond = Rad::CorporateBond.new(:ent_id => current_org.resource_id)
    else
      @rad_corporate_bond = Rad::CorporateBond.new
    end
  end

  # GET /rad/corporate_bonds/1/edit
  def edit
    @instance = Wf::ProcInst.find_by_resource(@rad_corporate_bond)
    @task = Wf::Task.find_by(PROC_INST_ID_: @instance.getId, ASSIGNEE_: current_user.wf_id, END_TIME_: nil)
  end

  # POST /rad/corporate_bonds
  # POST /rad/corporate_bonds.json
  def create
    @rad_corporate_bond = Rad::CorporateBond.new(rad_corporate_bond_params)

    respond_to do |format|
      if @rad_corporate_bond.save
        if current_org.resource.ent_level_code != '3'
          @rad_corporate_bond.create_wf_proc_resource(deployment_name: 'demo_act_2', variables: {'resource_type' => 'Rad::CorporateBond'})
        else
          @rad_corporate_bond.create_wf_proc_resource(deployment_name: 'demo_act', variables: {'resource_type' => 'Rad::CorporateBond'})
        end
        format.html { redirect_to rad_corporate_bonds_url, notice: 'Corporate bond was successfully updated.' }
        format.json { render :show, status: :created, location: @rad_corporate_bond }
      else
        format.html { render :new }
        format.json { render json: @rad_corporate_bond.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rad/corporate_bonds/1
  # PATCH/PUT /rad/corporate_bonds/1.json
  def update
    if params[:bs_next]
      @rad_corporate_bond.status = 'locked'
    end
    respond_to do |format|
      if @rad_corporate_bond.update(rad_corporate_bond_params)
        instance = Wf::ProcInst.find_by_resource(@rad_corporate_bond)
        task = Wf::Task.find_by(PROC_INST_ID_: instance.getId, ASSIGNEE_: current_user.wf_id, END_TIME_: nil)
        [[params[:option1], '业务角度'], [params[:option2], '经济角度'], [params[:option3], '社会效益'], [params[:option4], '角度四'], [params[:option5], '角度五']].each do |p|
          if !p[0].blank?
            opinion = task.task_opinions.build(opinion: p[0], name: p[1])
            opinion.save
          end
        end
        if params[:bs_next]
          Wf::Task.complete(@rad_corporate_bond, current_user, {'allow' => 'true'})
          format.html { redirect_to rad_corporate_bonds_url, notice: 'Corporate bond was successfully updated.' }
          format.json { render :show, status: :ok, location: @rad_corporate_bond }
        elsif params[:bs_prev]
          Wf::Task.complete(@rad_corporate_bond, current_user, {'allow' => 'false'})
          format.html { redirect_to rad_corporate_bonds_url, notice: 'Corporate bond was successfully updated.' }
          format.json { render :show, status: :ok, location: @rad_corporate_bond }
        else
          format.html { redirect_to edit_rad_corporate_bond_path(@rad_corporate_bond), notice: 'Corporate bond was successfully updated.' }
          format.json { render :show, status: :ok, location: @rad_corporate_bond }
        end
      else
        @instance = Wf::ProcInst.find_by_resource(@rad_corporate_bond)
        @task = Wf::Task.find_by(PROC_INST_ID_: @instance.getId, ASSIGNEE_: current_user.wf_id, END_TIME_: nil)
        format.html { render :edit }
        format.json { render json: @rad_corporate_bond.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rad/corporate_bonds/1
  # DELETE /rad/corporate_bonds/1.json
  def destroy
    @rad_corporate_bond.destroy
    respond_to do |format|
      format.html { redirect_to rad_corporate_bonds_url, notice: 'Corporate bond was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_file
    @rad_corporate_bond = params[:id] ? Rad::CorporateBond.find(params[:id]) : Rad::CorporateBond.new
    @the_file = @rad_corporate_bond.file_resources.build
    @index = params[:index].to_i
    respond_to do |format|
      format.js
    end
  end

  def del_file
    @file_id = params[:file_id]
    if params[:if_resource]=='yes'
      Fdn::FileResource.delete(params[:id])
    end
    respond_to do |format|
      format.html
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rad_corporate_bond
    @rad_corporate_bond = Rad::CorporateBond.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rad_corporate_bond_params
    params.require(:rad_corporate_bond).permit! if params[:rad_corporate_bond]
  end
end
