#coding: utf-8
class Fdn::LegendCategoriesController < ApplicationController
  before_action :set_fdn_legend_category, only: [:show, :edit, :update, :destroy]

  # GET /fdn/legend_categories
  # GET /fdn/legend_categories.json
  def index
    @fdn_legend_categories = Fdn::LegendCategory.show.paginate(page: params[:page]||1)
  end

  # GET /fdn/legend_categories/1
  # GET /fdn/legend_categories/1.json
  def show
  end

  def show_menhu
    @show_list = Fdn::LegendMenhu.all
  end

  def menhu_edit
    @menhu_show =Fdn::LegendMenhu.find(params[:id])
  end

  def menhu_update
    @menhu_show =Fdn::LegendMenhu.find(params[:id])
    if @menhu_show.update_attributes(fdn_legend_menhu_params)
      respond_to do |format|
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '门户更新成功！') }
      end
    else
      render :action => :menhu_edit
    end
  end

  # GET /fdn/legend_categories/new
  def new
    seq = Fdn::LegendCategory.where(parent_id: params[:parent_id]).map(&:position).max || 0
    @fdn_legend_category = Fdn::LegendCategory.new(position: seq+1)
  end

  # GET /fdn/legend_categories/1/edit
  def edit
  end

  def change_seq
    @seq = Fdn::LegendCategory.where(parent_id: params[:parent_id]).map(&:position).max || 0
    @seq += 1
  end

  # POST /fdn/legend_categories
  # POST /fdn/legend_categories.json
  def create
    @fdn_legend_category = Fdn::LegendCategory.new(fdn_legend_category_params)

    respond_to do |format|
      if @fdn_legend_category.save
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '栏目分类创建成功！') }
        format.json { render :show, status: :created, location: @fdn_legend_category }
      else
        format.html { render :new }
        format.json { render json: @fdn_legend_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fdn/legend_categories/1
  # PATCH/PUT /fdn/legend_categories/1.json
  def update
    respond_to do |format|
      if @fdn_legend_category.update(fdn_legend_category_params)
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '栏目分类创建成功！') }
        format.json { render :show, status: :ok, location: @fdn_legend_category }
      else
        format.html { render :edit }
        format.json { render json: @fdn_legend_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def stop
    @category = Fdn::LegendCategory.find_by_id params[:id]
    @category.status = params[:act]
    @category.save
    #redirect_to fdn_legend_categories_url
    #render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW',fdn_legend_categories_url,'状态修改成功！')
  end

  # DELETE /fdn/legend_categories/1
  # DELETE /fdn/legend_categories/1.json
  def destroy
    @fdn_legend_category.destroy
    respond_to do |format|
      format.html { redirect_to fdn_legend_categories_url, notice: 'Legend category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_fdn_legend_category
    @fdn_legend_category = Fdn::LegendCategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def fdn_legend_category_params
    params.require(:fdn_legend_category).permit(:name, :code, :parent_id, :seq)
  end

  def fdn_legend_menhu_params
    params.require(:fdn_legend_menhu).permit! if params[:fdn_legend_menhu]
  end
end
