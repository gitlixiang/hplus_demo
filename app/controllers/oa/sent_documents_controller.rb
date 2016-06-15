#coding: utf-8
class Oa::SentDocumentsController < ApplicationController
  before_action :set_oa_sent_document, only: [:show, :edit, :update, :destroy]
  #skip_before_filter :require_user
  # GET /oa/sent_documents
  # GET /oa/sent_documents.json
  def index
    @docs = Oa::SentDocument.all #.paginate(:page => params[:page], :order => 'created_at desc')
    Wf::Deployment.deploy(path: 'group_test.bpmn20.xml', name: 'group_test', group_name: 'test')
    @deployments = Wf::Deployment.list
                                 #查询待办事项
    @ntd = Wf::ActInst.find_ntd_by_user(current_user).select { |o| o.is_a?(Oa::SentDocument) }.uniq
                                 #查询已办事项
    @hd = Wf::ActInst.find_hd_by_user(current_user).select { |o| o.is_a?(Oa::SentDocument) }.uniq
                                 #查询办结事项
    @f = Wf::ActInst.find_f_by_user(current_user).select { |o| o.is_a?(Oa::SentDocument) }.uniq

    #sql = ActiveRecord::Base.connection()
    #arr = sql.select_all("SELECT ACT_HI_TASKINST.ID_ as task_id,
    #                     substring_index(`ACT_HI_IDENTITYLINK`.GROUP_ID_ ,'_',1) as org_code,
    #                     substring_index(`ACT_HI_IDENTITYLINK`.GROUP_ID_ ,'_',-1) as role_code
    #                     FROM ACT_HI_TASKINST inner join ACT_HI_IDENTITYLINK on ACT_HI_TASKINST.ID_ = ACT_HI_IDENTITYLINK.TASK_ID_
    #                     WHERE  ACT_HI_TASKINST.ASSIGNEE_ is null and ACT_HI_IDENTITYLINK.TYPE_='candidate'").to_hash
    #task_ids = []
    #arr.each do |a|
    #  if current_user.has_workflow_role(a["org_code"],a["role_code"])
    #    task_ids << a["task_id"]
    #  end
    #end
    #@task = Wf::Task.where("ID_ in (?)",task_ids)
    #@need_to_claim = Wf::ActInst.where("TASK_ID_ in (?)",task_ids).map{|t|t.wf_proc_inst.proc_resource.resource}.select{|o|o.is_a?(Oa::SentDocument)}.uniq

    # @logger = WfActiviti[:history].createHistoricProcessInstanceQuery.involvedUser('320500-user').finished.list.map{|p|p.getId}

    # definition = WfActiviti[:repository].createProcessDefinitionQuery.deploymentId('11').singleResult
    #
    # send_data Wf::Deployment.image_stream(definition).to_s, disposition: 'inline', type: 'image/png', filename: definition.getDiagramResourceName()

    # Wf::Task.complete(Oa::SentDocument.all.first, current_user, {'allow'=>'true'})


    #Wf::Task.complete(Oa::SentDocument.all.first, current_user, {'allow'=>'false'})

    #@items = Wf::Task.list(instance, {assignee:'320100-manager'})
    #@logger = @items
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @docs }
    end

    # 137691025-user
  end

  def claim_work
    @task_id = params[:task_id]
    Wf::Task.claim(@task_id, current_user.wf_id)
    redirect_to wf_index_rad_investments_path(tab_idx: 1) #oa_sent_documents_url
  end

  # GET /oa/sent_documents/1
  # GET /oa/sent_documents/1.json
  def show
    @oa_sent_document = Oa::SentDocument.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @oa_sent_document }
    end
  end

  # GET /oa/sent_documents/new
  # GET /oa/sent_documents/new.json
  def new
    #if !params[:resource_type].blank?&&para000ms[:resource_type] == "Hr::JobRevision"
    #  @hr_job_revision = Hr::JobRevision.find(params[:resource_id])
    #  content = "<center><h3>" + "关于" + @hr_job_revision.person.full_name + "同志职务任免的通知" + "</h3></center><br/>" + Hr::JobRevision.mix_job_revision_content(@hr_job_revision)
    #  @oa_sent_document = Oa::SentDocument.new(:title=>("关于" + @hr_job_revision.person.full_name + "同志职务任免的通知"),:content=>content)
    #elsif params[:sam_report_summary]
    #  puts params[:file]
    #  @org = Fdn::Organization.find(params[:ent_id])
    #  @sam_report_summary = Sam::ReportSummary.find(params[:sam_report_summary])
    #  @oa_sent_document = Oa::SentDocument.new(:title=>(@org.name + @sam_report_summary.check_date.year.to_s + '年' + @sam_report_summary.check_type ),:organization_id=>params[:ent_id])
    #  @files = Fdn::FileResource.find(params[:file])
    #else
    @oa_sent_document = Oa::SentDocument.new
    #@oa_sent_document.files.build
    #@oa_sent_document.doc_type_code = Oa::Lookups::DocType.select_y.first[1]
    #@oa_recv_document = Oa::RecvDocument.find_by_id(params[:recv_document_id])
    #end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @oa_sent_document }
    end
  end

  # GET /oa/sent_documents/1/edit
  def edit
    @oa_sent_document = Oa::SentDocument.find(params[:id])

    @instance = Wf::ProcInst.find_by_resource(@oa_sent_document)
    @task = Wf::Task.find_by(PROC_INST_ID_: @instance.getId, ASSIGNEE_: current_user.wf_id, END_TIME_: nil)
    #@act = Wf::ActInst.find_by(PROC_INST_ID_: @instance.getId, ASSIGNEE_: current_user.wf_id, END_TIME_: nil)
    #@oa_sent_document.process.wi_by_user(current_user.username)
  end

  # POST /oa/sent_documents
  # POST /oa/sent_documents.json
  def create
    @oa_sent_document = Oa::SentDocument.new(oa_sent_document_params)
    #@recv_document = Oa::RecvDocument.find_by_id(params[:recv_document_id])
    respond_to do |format|
      if @oa_sent_document.save
        #启动工作流
        @oa_sent_document.create_wf_proc_resource(deployment_name: 'group_test', variables: {'resource_type' => 'Oa::SendDocument'})

        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '发文创建成功！') }
        format.json { render :show, status: :created, location: @oa_sent_document }
      else
        format.html { render :new }
        format.json { render json: @oa_sent_document.errors, status: :unprocessable_entity }
      end
    end
    #respond_to do |format|
    #  if @oa_sent_document.save_with_recv(@recv_document) && @oa_sent_document.launch((@recv_document.process.id if @recv_document))
    #    format.html { redirect_to edit_oa_sent_document_url(@oa_sent_document), notice: '拟文创建成功' }
    #    format.json { render json: @oa_sent_document, status: :created, location: @oa_sent_document }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @oa_sent_document.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PUT /oa/sent_documents/1
  # PUT /oa/sent_documents/1.json
  def update
    if params[:bs_next]
      @oa_sent_document.status = 'locked'
    end
    #@oa_sent_document = Oa::SentDocument.find(params[:id])
    respond_to do |format|
      if @oa_sent_document.update(oa_sent_document_params)
        instance = Wf::ProcInst.find_by_resource(@oa_sent_document)
        task = Wf::Task.find_by(PROC_INST_ID_: instance.getId, ASSIGNEE_: current_user.wf_id, END_TIME_: nil)
        [[params[:option1], '业务角度'], [params[:option2], '经济角度'], [params[:option3], '社会效益'], [params[:option4], '角度四'], [params[:option5], '角度五']].each do |p|
          if !p[0].blank?
            opinion = task.task_opinions.build(opinion: p[0], name: p[1])
            opinion.save
          end
        end
        if params[:bs_next]
          Wf::Task.complete(@oa_sent_document, current_user, {'allow' => 'true'})
          format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '发文提交成功！') }
          format.json { render :show, status: :ok, location: @oa_sent_document }
        elsif params[:bs_prev]
          Wf::Task.complete(@oa_sent_document, current_user, {'allow' => 'false'})
          format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '发文退回成功！') }
          format.json { render :show, status: :ok, location: @oa_sent_document }
        else
          format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '发文更新成功！') }
          format.json { render :show, status: :ok, location: @oa_sent_document }
        end
      else
        @instance = Wf::ProcInst.find_by_resource(@oa_sent_document)
        @task = Wf::Task.find_by(PROC_INST_ID_: @instance.getId, ASSIGNEE_: current_user.wf_id, END_TIME_: nil)
        format.html { render :edit }
        format.json { render json: @oa_sent_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /oa/sent_documents/1
  # DELETE /oa/sent_documents/1.json
  def destroy
    @oa_sent_document = Oa::SentDocument.find(params[:id])
    @oa_sent_document.destroy

    respond_to do |format|
      format.html { redirect_to oa_sent_documents_url }
      format.json { head :ok }
    end
  end

  def add_file
    @oa_sent_document = params[:id] ? Oa::SentDocument.find(params[:id]) : Oa::SentDocument.new
    @the_file = @oa_sent_document.file_resources.build
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_oa_sent_document
    @oa_sent_document = Oa::SentDocument.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def oa_sent_document_params
    params.require(:oa_sent_document).permit! if params[:oa_sent_document]
  end

end
