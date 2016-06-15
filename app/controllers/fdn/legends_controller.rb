#coding: utf-8
class Fdn::LegendsController < ApplicationController
  skip_before_filter :require_user, :only => ['show_page', 'menhu_show', 'menhu_legend_list']
  skip_before_filter :authorize
  before_action :set_fdn_legend, only: [:show, :edit, :update, :destroy, :show_page, :menhu_show]

  def important

  end

  def gov_widget
    # @fdn_legends = Fdn::Legend.dept_resources.take(7)
    @images = Fdn::Legend.dept_resources.hefei.select { |l| l.file_resources.size>0 }
    @articles = Fdn::Legend.dept_resources.hefei.select { |l| l.file_resources.size==0 }
  end

  def gov_content
    @fdn_legends = Fdn::Legend.dept_resources.take(7)
  end

  def ent_widget
    @fdn_legends = Fdn::Legend.qiye.take(7)
  end

  def district_widget
    @fdn_legends = Fdn::Legend.district.take(7)
  end

  # GET /fdn/legends
  def index
    if params[:type]
      if params[:type] == 'gov'
        @fdn_legends = Fdn::Legend.dept_resources.hefei.paginate(page: params[:legend_page]||1)
      elsif params[:type] == 'ent'
        @fdn_legends = Fdn::Legend.qiye.paginate(page: params[:legend_page]||1)
      elsif params[:type] == 'district'
        @fdn_legends = Fdn::Legend.district.paginate(page: params[:legend_page]||1)
      else
        @fdn_legends = Fdn::Legend.dept_resources.paginate(page: params[:legend_page]||1)
      end
    else
      if current_user.is_a_QXGZW?
        @fdn_legends = Fdn::Legend.where(creator: current_user.id).paginate(page: params[:legend_page]||1)
      else
        @fdn_legends = Fdn::Legend.search_org_id(current_org.id).paginate(page: params[:legend_page]||1)
      end
    end
  end

  # GET /fdn/legends/1
  def show
  end

  def show_page

  end

  def menhu_show
    @fdn_legend_category = @fdn_legend.legend_type
    @root = @fdn_legend_category.root
    render layout: 'login'
  end

  def menhu_legend_list
    @fdn_legend_category = Fdn::LegendCategory.find params[:type_code]
    @root = @fdn_legend_category.root
    if @fdn_legend_category.leaf?
      @fdn_legends = Fdn::Legend.where(type_code: params[:type_code]).paginate(page: params[:page]||1)
    else
      @fdn_legends = Fdn::Legend.where(type_code: @fdn_legend_category.descendants.map(&:id)).paginate(page: params[:page]||1)
    end

    render layout: 'login'
  end

  # GET /fdn/legends/new
  def new
    @fdn_legend = Fdn::Legend.new
  end

  # GET /fdn/legends/1/edit
  def edit
  end

  # POST /fdn/legends
  def create
    @fdn_legend = Fdn::Legend.new(fdn_legend_params)
    respond_to do |format|
      if @fdn_legend.save
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '通知公告创建成功！') }
        format.json { render :show, status: :created, location: @fdn_legend }
      else
        format.html { render :new }
        format.json { render json: @fdn_legend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fdn/legends/1
  def update
    respond_to do |format|
      if @fdn_legend.update(fdn_legend_params)
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '通知公告更新成功！') }
        format.json { render :show, status: :ok, location: @fdn_legend }
      else
        format.html { render :edit }
        format.json { render json: @fdn_legend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fdn/legends/1
  def destroy
    @fdn_legend.destroy
    redirect_to fdn_legends_url
  end

  def add_file
    @fdn_legend = params[:id] ? Fdn::Legend.find(params[:id]) : Fdn::Legend.new
    @the_file = @fdn_legend.file_resources.build(:display_name => "img")
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

  def add_file_of
    @fdn_legend = params[:id] ? Fdn::Legend.find(params[:id]) : Fdn::Legend.new
    @the_file = @fdn_legend.file.build(:display_name => "file")
    @index = params[:index].to_i
    respond_to do |format|
      format.js
    end
  end

  def del_file_of
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
  def set_fdn_legend
    @fdn_legend = Fdn::Legend.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def fdn_legend_params
    params.require(:fdn_legend).permit! if params[:fdn_legend]
    # params.require(:fdn_legend).permit(:org_id, :type_code, :title, :content, :file_resources_attributes => [:filename, :ffx,:display_name,:],:file_attributes => [:filename, :ffx,:display_name])
  end
end
