#coding:utf-8
class Pm::ProgressesController < ApplicationController
  before_action :set_pm_progress, only: [:show, :edit, :update, :destroy, :submit, :return, :finish, :close]

  def submit
    @pm_progress.wf.submit!
    # redirect_to list_pm_progress_url(@pm_progress.pm_plan)
    respond_to do |format|
      format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '提交成功！') }
    end
  end

  def return
    @pm_progress.wf.return!
    # redirect_to list_pm_progress_url(@pm_progress.pm_plan)
    respond_to do |format|
      format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '退回成功！') }
    end
  end

  def finish
    @pm_progress.wf.finish!
    # redirect_to list_pm_progress_url(@pm_progress.pm_plan)
    respond_to do |format|
      format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '同意！') }
    end
  end

  def close
    @pm_progress.wf.close!
    # redirect_to list_pm_progress_url(@pm_progress.pm_plan)
    respond_to do |format|
      format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '关闭成功！') }
    end
  end

  # GET /pm/progresses
  # GET /pm/progresses.json
  def index
    # if current_user.org.id == 1
    @pm_plans = Pm::Plan.joins(:wf).where('pm_work_flows.state = ?', 'rec').paginate(:page => params[:page])
    # else
    #   @pm_plans = Pm::Plan.paginate(:page => params[:page])
    # end
  end

  def list
    @pm_plan = Pm::Plan.find(params[:id])
    @pm_progresses = @pm_plan.pm_progresses
    p 'aaa'
    p @pm_progresses
  end

  # GET /pm/progresses/1
  # GET /pm/progresses/1.json
  def show
  end

  # GET /pm/progresses/new
  def new
    pm_node = Pm::Node.find(params[:node_id])
    @pm_progress = pm_node.build_pm_progress(plan_id: pm_node.plan_id, node: pm_node.name, start_date: pm_node.start_date, end_date: pm_node.end_date)
  end

  # GET /pm/progresses/1/edit
  def edit
  end

  # POST /pm/progresses
  # POST /pm/progresses.json
  def create
    @pm_progress = Pm::Progress.new(pm_progress_params)

    respond_to do |format|
      if @pm_progress.save
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '进度创建成功！') }
        format.json { render :show, status: :created, location: @pm_progress }
      else
        format.html { render :new }
        format.json { render json: @pm_progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pm/progresses/1
  # PATCH/PUT /pm/progresses/1.json
  def update
    respond_to do |format|
      if @pm_progress.update(pm_progress_params)
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '进度更新成功！') }
        format.json { render :show, status: :ok, location: @pm_progress }
      else
        format.html { render :edit }
        format.json { render json: @pm_progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pm/progresses/1
  # DELETE /pm/progresses/1.json
  def destroy
    @pm_progress.destroy
    respond_to do |format|
      format.html { redirect_to list_pm_progress_path(@pm_progress.pm_plan.id), notice: 'Progress was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pm_progress
    @pm_progress = Pm::Progress.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pm_progress_params
    params.require(:pm_progress).permit(:status, :percent, :content, :node, :node_id, :plan_id, :sort_seq, :start_date, :end_date)
  end
end
