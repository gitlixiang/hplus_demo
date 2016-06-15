#coding: utf-8
class Hr::LeaderSalariesController < ApplicationController
  before_action :set_hr_leader_salary, only: [:show, :edit, :update, :destroy]

  # GET /hr/leader_salaries
  # GET /hr/leader_salaries.json
  def index
    @years = Cl::year_ary(Hr::LeaderSalary, :year)
    @hr_leader_salaries = Hr::LeaderSalary.all.take(20)
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id].to_s
  end

  def detail_refresh
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id].to_s
    org = Fdn::Organization.find @org_id
    if org.is_ent?
      @people = org.people
      ary = @people.map(&:id)
    else
      ary = [0]
    end
    @hr_leader_salaries = Hr::LeaderSalary.persons(ary).year(params[:year]).take(20)
  end

  # GET /hr/leader_salaries/1
  # GET /hr/leader_salaries/1.json
  def show
  end

  # GET /hr/leader_salaries/new
  def new
    @people = Fdn::Organization.find(params[:org_id]).people
    @hr_leader_salary = Hr::LeaderSalary.new(year: params[:year], month: params[:month])
  end

  # GET /hr/leader_salaries/1/edit
  def edit
    @people = @hr_leader_salary.hr_person.fdn_organization.people
  end

  # POST /hr/leader_salaries
  # POST /hr/leader_salaries.json
  def create
    @hr_leader_salary = Hr::LeaderSalary.new(hr_leader_salary_params)

    respond_to do |format|
      if @hr_leader_salary.save
        format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'hr/leader_salaries', :action => :detail_refresh), {org_id: @hr_leader_salary.hr_person.fdn_organization.id, year: @hr_leader_salary.year, month: @hr_leader_salary.month}, '工资创建成功！') }
        format.json { render :show, status: :created, location: @hr_leader_salary }
      else
        format.html { render :new }
        format.json { render json: @hr_leader_salary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hr/leader_salaries/1
  # PATCH/PUT /hr/leader_salaries/1.json
  def update
    respond_to do |format|
      if @hr_leader_salary.update(hr_leader_salary_params)
        format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'hr/leader_salaries', :action => :detail_refresh), {org_id: @hr_leader_salary.hr_person.fdn_organization.id, year: @hr_leader_salary.year, month: @hr_leader_salary.month}, '工资修改成功！') }
        format.json { render :show, status: :ok, location: @hr_leader_salary }
      else
        format.html { render :edit }
        format.json { render json: @hr_leader_salary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hr/leader_salaries/1
  # DELETE /hr/leader_salaries/1.json
  def destroy
    @hr_leader_salary.destroy
    respond_to do |format|
      format.html { redirect_to hr_leader_salaries_url, notice: 'Leader salary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hr_leader_salary
    @hr_leader_salary = Hr::LeaderSalary.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hr_leader_salary_params
    params.require(:hr_leader_salary).permit!
  end
end
