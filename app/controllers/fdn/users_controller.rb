#coding:utf-8
class Fdn::UsersController < ApplicationController
  before_action :set_fdn_user, only: [:show, :edit, :update, :destroy, :pre_edit]

  # GET /fdn/users
  # GET /fdn/users.json
  def index
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id]
    @org = Fdn::Organization.find @org_id
    @search = Fdn::User.search(params[:q])
    @users = @search.result.by_org_id(@org_id).paginate(:page => params[:page])
    # # rest
    # #获得所有部署的工作流
    # @response = RestClient.get 'http://kermit:kermit@localhost:8080/activiti-rest/service/repository/deployments'

    # #部署一个工作流
    # RestClient.post 'http://kermit:kermit@localhost:8080/activiti-rest/service/repository/deployments',
    #                 {:file => Rails.root.join('doc', 'assignee.bpmn20.xml')}

    # #激活一个定义
    # RestClient.put 'http://kermit:kermit@localhost:8080/activiti-rest/service/repository/process-definitions/process:1:2504',
    #                 {"action" => "activate",
    #     "includeProcessInstances" => "true",
    #     "date" => "2015-06-11T17:26:12Z"}.to_json, :content_type => :json, :accept => :json

    # path = Rails.root.join('deps', 'test.bpmn20.xml').to_s
    # file = File.open(path)
    # filename = File.basename(file.path).split('.').first
    # require 'open-uri'
    # data = open(path) { |f| f.read }

    deployment = Wf::Deployment.deploy(path: 'gzw.bpmn20.xml', name: 'gzw_deploy', group_name: 'gzw_group')

    # 列出所有部署
    @deployments = Wf::Deployment.list

    # 查询部署下面的流程定义和个数
    definition = Wf::ProcDef.list(deployment).singleResult
    @count = Wf::ProcDef.active(deployment).count

    # 查询流程定义下面的流程实例，如果没有就新建
    @instances_count = Wf::ProcInst.list(definition).count

    if definition && @instances_count == 0
      instance = Wf::ProcInst.start(definition, {'code' => 'first'})
    else
      instance = Wf::ProcInst.list(definition)
    end


    # # 查询当前用户的任务
    # params[:unassigned] = 'false'
    # params[:assignee] = '320100-user'
    # # params[:candidate_group] = '320100_BZ'
    # @items = Wf::Task.list(instance, params)

    # Wf::Task.claim(@items[0][:id], '320100-user')

    # # 完成工作流
    # Wf::Task.complete(@items[0][:id], {'finish'=>'true'})

    # 流程图
    # send_data Wf::Deployment.image_stream(definition).to_s, disposition: 'attachment', type: 'image/png', filename: definition.getDiagramResourceName()

    # 获得流程定义文件
    # send_data Wf::Deployment.bpmn(definition).to_s, disposition: 'inline', type: 'text/xml', filename: definition.getResourceName

    # 流程节点图
    # send_data Wf::ProcInst.image_stream(instance).to_s, disposition: 'inline', type: 'image/png', filename: definition.getDiagramResourceName()

    # @logger = Wf::Deployment.bpmn(definition).to_s


    # render json: {
    #     data: Base64::strict_encode64(bytes.to_s)
    # }
    # image = ImageIO.read(image)
    # @image = javax.imageio.ImageIO.write(image, 'png', File.new('gzw.png'))
    # @image = javax.imageio.ImageIO.write(image,"png".to_java,
    #                                      java.io.File.new('gzw.png'))
    # @image = Wf::ByteArray.find_by(DEPLOYMENT_ID_:1,NAME_:'gzw.gzw.png').BYTES_.force_encoding("UTF-8")
    # io = image.to_io
    # @image = io.read
    # @image = bytes.to_s

    # #查询流程到哪个节点
    # pi = WfActiviti[:runtime].createProcessInstanceQuery().processInstanceId(instance.getId).singleResult()
    # if pi
    #   @logger = 'point:' + pi.getActivityId()
    # else
    #   @logger = 'finish'
    # end
    #
    # @logger = instance.getId

    # @logger = WfActiviti[:runtime].createProcessInstanceQuery.involvedUser('320100-user').count


    # WfActiviti[:runtime].startProcessInstanceByKey("test")

    # #列出流程定义
    # definitions = WfActiviti[:repository].createProcessDefinitionQuery.list.map do |item|
    #   {
    #       id: item.getId,
    #       name: item.getName,
    #       key: item.getKey,
    #       deployment_id: item.getDeploymentId,
    #       version: item.getVersion,
    #       diagram_resource_name: item.getDiagramResourceName,
    #       resource_name: item.getResourceName
    #   }
    # end
    # render json: definitions

  end

  def detail_refresh
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id]
    @org = Fdn::Organization.find @org_id
    @search = Fdn::User.search(params[:q])
    @users = @search.result.by_org_id(@org_id).paginate(:page => params[:page])
  end

  # GET /fdn/users/1
  # GET /fdn/users/1.json
  def show
  end

  # GET /fdn/users/new
  def new
    @org_id = params[:org_id]||session[:org_id]
    @fdn_user = Fdn::User.new()
    @fdn_user.build_user_information
    @fdn_user.resource = Fdn::Organization.find(params[:org_id])
  end

  # GET /fdn/users/1/edit
  def edit
  end

  def pre_edit
    @fdn_user = Fdn::User.find(params[:id])
    @file = @fdn_user.user_information.file_resources.build
  end

  def pre_update
    @fdn_user = Fdn::User.find(params[:id])
    @fdn_user.update_attributes(fdn_user_params.merge({updated_by: current_user.id}))
    if @fdn_user.update_attributes(fdn_user_params.merge({updated_by: current_user.id}))
      respond_to do |format|
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '用户修改成功！') }
      end
    else
      render :action => :per_edit
    end
  end

  # POST /fdn/users
  # POST /fdn/users.json
  def create
    @fdn_user = Fdn::User.new(fdn_user_params)
    @fdn_user.resource = Fdn::Organization.find(params[:org_id])

    respond_to do |format|
      if @fdn_user.save
        format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'fdn/users', :action => :detail_refresh), {org_id: @fdn_user.resource_id}, '用户创建成功！') }
        #format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW','用户创建成功！') }
        format.json { render :show, status: :created, location: @fdn_user }
      else
        format.html { render :new }
        format.json { render json: @fdn_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fdn/users/1
  # PATCH/PUT /fdn/users/1.json
  def update
    cq_size = 0
    if !fdn_user_params[:cq_users_attributes].blank?
      fdn_user_params[:cq_users_attributes].each { |key, value| cq_size = cq_size + 1 if value[:status]== 'Y' }
    end
    kb_size = 0
    if !fdn_user_params[:kb_users_attributes].blank?
      fdn_user_params[:kb_users_attributes].each { |key, value| kb_size = kb_size + 1 if value[:status]== 'Y' }
    end
    nb_size = 0
    if !fdn_user_params[:nb_users_attributes].blank?
      fdn_user_params[:nb_users_attributes].each { |key, value| nb_size = nb_size + 1 if value[:status]== 'Y' }
    end
    ys_size = 0
    if !fdn_user_params[:ys_users_attributes].blank?
      fdn_user_params[:ys_users_attributes].each { |key, value| ys_size = ys_size + 1 if value[:status]== 'Y' }
    end
    js_size = 0
    if !fdn_user_params[:js_users_attributes].blank?
      fdn_user_params[:js_users_attributes].each { |key, value| js_size = js_size + 1 if value[:status]== 'Y' }
    end
    if cq_size > 1 || kb_size > 1 || nb_size > 1 || ys_size > 1 || js_size > 1
      @fdn_user.user_error(true)
      #flash[:notice] = '产权帐号列表中-当前帐号值重复！'
      render :action => :edit
    elsif @fdn_user.update(fdn_user_params)
      respond_to do |format|
        format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'fdn/users', :action => :detail_refresh), {org_id: @fdn_user.resource_id}, '用户修改成功！') }
        format.json { render :show, status: :ok, location: @fdn_user }
      end
      # redirect_to per_edit_fdn_user_url(@fdn_user, :predef_opi_type_code => params['predef_opi_type_code'])
    else
      render :action => :edit
    end
  end

  def add_jq_user
    @fdn_user = Fdn::User.find(params[:id])
    @type = params[:type]
    @jq_user = @fdn_user.jq_users.build(resource_type: @type)
    @table_id = params[:table_id]
    @index_name = params[:index_name]
    @index = params[:index].to_i
    respond_to do |format|
      format.js
    end
  end

  def del_jq_user
    @id = params[:id]
    @jq_user = Fdn::JqUser.find(params[:id])
    #@user = @jq_user.user
    #@type = @jq_user.resource_type
    @jq_user.delete
    respond_to do |format|
      format.html
    end
  end

  # DELETE /fdn/users/1
  # DELETE /fdn/users/1.json
  def destroy
    @fdn_user.destroy
    respond_to do |format|
      format.html { redirect_to fdn_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def stop
    @users = Fdn::User.find_by_id params[:id]
    @users.status = params[:act]
    @users.save
    redirect_to detail_refresh_fdn_users_url(:org_id => @users.resource_id)
    #respond_to do |format|
    #  format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW',url_for(:controller => 'fdn/users',:action => :detail_refresh),{org_id: @fdn_user.resource_id},'用户修改成功！')}
    #end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_fdn_user
    @fdn_user = Fdn::User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def fdn_user_params
    params.require(:fdn_user).permit! if params[:fdn_user]
  end
end
