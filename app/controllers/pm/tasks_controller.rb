class Pm::TasksController < ApplicationController
  before_action :set_pm_task, only: [:show, :edit, :update, :destroy]

  # GET /pm/tasks
  # GET /pm/tasks.json
  def index
    @pm_tasks = Pm::Task.all
  end

  # GET /pm/tasks/1
  # GET /pm/tasks/1.json
  def show
  end

  # GET /pm/tasks/new
  def new
    @pm_task = Pm::Task.new
  end

  # GET /pm/tasks/1/edit
  def edit
  end

  # POST /pm/tasks
  # POST /pm/tasks.json
  def create
    @pm_task = Pm::Task.new(pm_task_params)

    respond_to do |format|
      if @pm_task.save
        format.html { redirect_to @pm_task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @pm_task }
      else
        format.html { render :new }
        format.json { render json: @pm_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pm/tasks/1
  # PATCH/PUT /pm/tasks/1.json
  def update
    respond_to do |format|
      if @pm_task.update(pm_task_params)
        format.html { redirect_to @pm_task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @pm_task }
      else
        format.html { render :edit }
        format.json { render json: @pm_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pm/tasks/1
  # DELETE /pm/tasks/1.json
  def destroy
    @pm_task.destroy
    respond_to do |format|
      format.html { redirect_to pm_tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pm_task
    @pm_task = Pm::Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pm_task_params
    params.require(:pm_task).permit(:name, :content, :org_id, :resource_id)
  end
end
