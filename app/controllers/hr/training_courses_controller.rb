#coding: utf-8
class Hr::TrainingCoursesController < ApplicationController
  before_action :set_hr_training_course, only: [:show, :edit, :update, :destroy]

  # GET /hr/training_courses
  # GET /hr/training_courses.json
  def index
    params[:q] = params[:q] ? params[:q] : {}
    @search = Hr::TrainingCourse.ransack(params[:q])
    @hr_training_courses = @search.result.paginate(:page => params[:page])
  end

  def course_index

  end

  # GET /hr/training_courses/1
  # GET /hr/training_courses/1.json
  def show
  end

  # GET /hr/training_courses/new
  def new
    @hr_training_course = Hr::TrainingCourse.new
  end

  # GET /hr/training_courses/1/edit
  def edit
  end

  # POST /hr/training_courses
  # POST /hr/training_courses.json
  def create
    @hr_training_course = Hr::TrainingCourse.new(hr_training_course_params)

    respond_to do |format|
      if @hr_training_course.save
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '创建成功！') }
        format.json { render :show, status: :created, location: @hr_training_course }
      else
        format.html { render :new }
        format.json { render json: @hr_training_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hr/training_courses/1
  # PATCH/PUT /hr/training_courses/1.json
  def update
    respond_to do |format|
      if @hr_training_course.update(hr_training_course_params)
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '修改成功！') }
        format.json { render :show, status: :ok, location: @hr_training_course }
      else
        format.html { render :edit }
        format.json { render json: @hr_training_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hr/training_courses/1
  # DELETE /hr/training_courses/1.json
  def destroy
    @hr_training_course.destroy
    respond_to do |format|
      format.html { redirect_to hr_training_courses_url, notice: 'Training course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hr_training_course
    @hr_training_course = Hr::TrainingCourse.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hr_training_course_params
    params.require(:hr_training_course).permit! if params[:hr_training_course]
  end
end
