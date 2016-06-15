#coding: utf-8
class Pm::PlansController < ApplicationController
  before_action :set_pm_plan, only: [:show, :edit, :update, :destroy, :submit, :return, :finish, :close]

  def submit
    @pm_plan.wf.submit!
    # redirect_to pm_plans_url
    respond_to do |format|
      format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '提交成功！') }
    end
  end

  def return
    @pm_plan.wf.return!
    # redirect_to pm_plans_url
    respond_to do |format|
      format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '退回成功！') }
    end
  end

  def finish
    @pm_plan.wf.finish!
    # redirect_to pm_plans_url
    respond_to do |format|
      format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '同意！') }
    end
  end

  def close
    @pm_plan.wf.close!
    # redirect_to pm_plans_url
    respond_to do |format|
      format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '关闭成功！') }
    end
  end

  def add_node
    @pm_plan = params[:id] ? Pm::Plan.find(params[:id]) : Pm::Plan.new
    @the_node = @pm_plan.pm_nodes.build
    @index = params[:index].to_i
    respond_to do |format|
      format.js
    end
  end

  def del_node
    @node_id = params[:id]
    Pm::Node.delete(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # GET /pm/plans
  # GET /pm/plans.json
  def index
    if current_user.org.id == 1
      @pm_plans = Pm::Plan.joins(:wf).where('pm_work_flows.state != ?', 'ipt').paginate(:page => params[:page])
    else
      @pm_plans = Pm::Plan.paginate(:page => params[:page])
    end

  end

  # GET /pm/plans/1
  # GET /pm/plans/1.json
  def show
  end

  # GET /pm/plans/new
  def new
    @pm_plan = Pm::Plan.new(name: params[:name], resource_id: params[:resource_id], resource_type: params[:resource_type])
  end

  # GET /pm/plans/1/edit
  def edit
  end

  # POST /pm/plans
  # POST /pm/plans.json
  def create
    @pm_plan = Pm::Plan.new(pm_plan_params)
    @pm_plan.org_id = current_org.id

    respond_to do |format|
      if @pm_plan.save
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '计划创建成功！') }
        format.json { render :show, status: :created, location: @pm_plan }
      else
        format.html { render :new }
        format.json { render json: @pm_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pm/plans/1
  # PATCH/PUT /pm/plans/1.json
  def update
    respond_to do |format|
      if @pm_plan.update(pm_plan_params)
        format.html { redirect_to @pm_plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @pm_plan }
      else
        format.html { render :edit }
        format.json { render json: @pm_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pm/plans/1
  # DELETE /pm/plans/1.json
  def destroy
    @pm_plan.destroy
    respond_to do |format|
      format.html { redirect_to pm_plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pm_plan
    @pm_plan = Pm::Plan.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pm_plan_params
    # params.require(:pm_plan).permit!#(:name, :contact, :phone, :content, :org_id, :stage)
    params.require(:pm_plan).permit! if params[:pm_plan]
  end
end
