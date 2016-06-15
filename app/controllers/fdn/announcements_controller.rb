#coding: utf-8
class Fdn::AnnouncementsController < ApplicationController
  before_action :set_fdn_announcement, only: [:show, :edit, :update, :destroy]

  # GET /fdn/announcements
  def index
    @fdn_announcements = Fdn::Announcement.paginate(:page => params[:page])
  end

  # GET /fdn/announcements/1
  def show
  end

  # GET /fdn/announcements/new
  def new
    @fdn_announcement = Fdn::Announcement.new
  end

  # GET /fdn/announcements/1/edit
  def edit
  end

  # POST /fdn/announcements
  def create
    @fdn_announcement = Fdn::Announcement.new(fdn_announcement_params)
    respond_to do |format|
      if @fdn_announcement.save
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '系统公告创建成功！') }
        format.json { render :show, status: :created, location: @fdn_announcement }
      else
        format.html { render :new }
        format.json { render json: @fdn_announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fdn/announcements/1
  def update
    respond_to do |format|
      if @fdn_announcement.update(fdn_announcement_params)
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '系统公告更新成功！') }
        format.json { render :show, status: :ok, location: @fdn_announcement }
      else
        format.html { render :edit }
        format.json { render json: @fdn_announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fdn/announcements/1
  def destroy
    @fdn_announcement.destroy
    #respond_to do |format|
    #  format.html { render :js => view_context.delete_refresh_div_show_tips('通知公告删除成功。')  }
    #end
    redirect_to fdn_announcements_url, notice: '通知公告删除成功。'
  end


  def add_file
    @fdn_announcement = params[:id] ? Fdn::Announcement.find(params[:id]) : Fdn::Announcement.new
    @the_file = @fdn_announcement.file_resources.build
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
  def set_fdn_announcement
    @fdn_announcement = Fdn::Announcement.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def fdn_announcement_params
    params.require(:fdn_announcement).permit! if params[:fdn_announcement]
  end
end
