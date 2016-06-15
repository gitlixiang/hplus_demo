#coding: utf-8
class Hr::TrainingInfosController < ApplicationController
  before_action :set_hr_training_info, only: [:show, :edit, :update, :destroy]

  # GET /hr/training_infos
  # GET /hr/training_infos.json
  def index
    params[:q] = params[:q] ? params[:q] : {}
    @search = Hr::TrainingInfo.ransack(params[:q])
    @hr_training_infos = @search.result.paginate(:page => params[:page])
  end

  # GET /hr/training_infos/1
  # GET /hr/training_infos/1.json
  def show
  end

  # GET /hr/training_infos/new
  def new
    @hr_training_info = Hr::TrainingInfo.new
  end

  # GET /hr/training_infos/1/edit
  def edit
  end

  # POST /hr/training_infos
  # POST /hr/training_infos.json
  def create
    @hr_training_info = Hr::TrainingInfo.new(hr_training_info_params)

    respond_to do |format|
      if @hr_training_info.save
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '创建成功！') }
        format.json { render :show, status: :created, location: @hr_training_info }
      else
        format.html { render :new }
        format.json { render json: @hr_training_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hr/training_infos/1
  # PATCH/PUT /hr/training_infos/1.json
  def update
    respond_to do |format|
      if @hr_training_info.update(hr_training_info_params)
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '修改成功！') }
        format.json { render :show, status: :ok, location: @hr_training_info }
      else
        format.html { render :edit }
        format.json { render json: @hr_training_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hr/training_infos/1
  # DELETE /hr/training_infos/1.json
  def destroy
    @hr_training_info.destroy
    respond_to do |format|
      format.html { redirect_to hr_training_infos_url, notice: 'Training info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hr_training_info
    @hr_training_info = Hr::TrainingInfo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hr_training_info_params
    params.require(:hr_training_info).permit! if params[:hr_training_info]
  end
end
