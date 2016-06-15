#coding: utf-8
class Oa::RecvDocumentsController < ApplicationController
  # GET /oa/recv_documents
  # GET /oa/recv_documents.json
  def index
    @docs = Oa::RecvDocument.by_user_id(current_user.id).paginate(:page => params[:page]).order('created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @oa_recv_documents }
    end
  end

  # GET /oa/recv_documents/1
  # GET /oa/recv_documents/1.json
  def show
    @oa_recv_document = Oa::RecvDocument.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @oa_recv_document }
    end
  end

  # GET /oa/recv_documents/new
  # GET /oa/recv_documents/new.json
  def new
    @oa_recv_document = Oa::RecvDocument.new
    #@oa_recv_document.other_files.build.build_file_resource

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @oa_recv_document }
    end
  end

  # GET /oa/recv_documents/1/edit
  def edit
    @oa_recv_document = Oa::RecvDocument.find(params[:id])
    #@oa_recv_document.process.wi_by_user(current_user.username)
  end

  # POST /oa/recv_documents
  # POST /oa/recv_documents.json
  def create
    @oa_recv_document = Oa::RecvDocument.new(oa_recv_document_params)
    respond_to do |format|
      if @oa_recv_document.save
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW','收文创建成功！') }
        format.json { render :show, status: :created, location: @oa_recv_document }
      else
        format.html { render :new }
        format.json { render json: @oa_recv_document.errors, status: :unprocessable_entity }
      end
    end
    #respond_to do |format|
    #  if @oa_recv_document.save && @oa_recv_document.launch
    #    format.html { redirect_to edit_oa_recv_document_url(@oa_recv_document) }
    #    format.json { render json: @oa_recv_document, status: :created, location: @oa_recv_document }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @oa_recv_document.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PUT /oa/recv_documents/1
  # PUT /oa/recv_documents/1.json
  def update
    @oa_recv_document = Oa::RecvDocument.find(params[:id])
    respond_to do |format|
      if @oa_recv_document.update(oa_recv_document_params)
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW','收文更新成功！')  }
        format.json { render :show, status: :ok, location: @oa_recv_document }
      else
        format.html { render :edit }
        format.json { render json: @oa_recv_document.errors, status: :unprocessable_entity }
      end
    end
    #@oa_recv_document.process.wi_by_user(current_user.username)
    #respond_to do |format|
    #
    #  if update_result(@oa_recv_document, params[:oa_recv_document], wf_params, validate_wf_params(wf_params))
    #    format.html { redirect_to oa_recv_documents_url }
    #    format.json { head :ok }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @oa_recv_document.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  def proc
    @oa_recv_document = Oa::RecvDocument.find(params[:id])
    save_group('view_user_id')
    respond_to do |format|

      if update_result(@oa_recv_document, params[:oa_recv_document], wf_params, validate_wf_params(wf_params))
        if params['write_doc']
          format.html { redirect_to new_oa_sent_document_url(:recv_document_id=>@oa_recv_document.id)}
        elsif params['save']
          format.html { redirect_to edit_wf_process_url(@oa_recv_document.process.id, :wf_act_id=> params[:wf_act_id])}
        else
          format.html { redirect_to wf_processes_url }
          format.json { head :ok }
        end
      else
        @resource = @oa_recv_document
        @wf_process = @resource.process
        @wf_process.wi_by_user(current_user.username)
        format.html { render :file=>'/wf/processes/edit' }
        format.json { render json: @oa_recv_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /oa/recv_documents/1
  # DELETE /oa/recv_documents/1.json
  def destroy
    @oa_recv_document = Oa::RecvDocument.find(params[:id])
    @oa_recv_document.destroy

    respond_to do |format|
      format.html { redirect_to oa_recv_documents_url }
      format.json { head :ok }
    end
  end

  def add_file
    @oa_recv_document = params[:id] ? Oa::RecvDocument.find(params[:id]) : Oa::RecvDocument.new
    @the_file = @oa_recv_document.file_resources.build
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
    def set_oa_recv_document
      @oa_recv_document = Oa::RecvDocument.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def oa_recv_document_params
      params.require(:oa_recv_document).permit! if params[:oa_recv_document]
    end

end
