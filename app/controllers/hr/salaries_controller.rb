#coding: utf-8
class Hr::SalariesController < ApplicationController
  before_action :set_hr_salary, only: [:show, :edit, :update, :destroy]

  # GET /hr/salaries
  # GET /hr/salaries.json
  def index
    @years = Cl::year_ary(Hr::Salary, :year)
    @hr_salaries = Hr::Salary.all.paginate(:page => params[:page], per_page:10)
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id].to_s
  end

  def detail_refresh
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id].to_s
    org = Fdn::Organization.find @org_id
    if org.is_ent?
      @people = org.people
      ary =  @people.map(&:id)
    else
      ary = [0]
    end
    @hr_salaries = Hr::Salary.persons(ary).year(params[:year]).month(params[:month]).paginate(:page => params[:page], per_page:10)
  end

  # GET /hr/salaries/1
  # GET /hr/salaries/1.json
  def show
  end

  # GET /hr/salaries/new
  def new
    @people = Hr::Person.where(org_id: params[:org_id])
    @hr_salary = Hr::Salary.new(year: params[:year], month: params[:month])
  end

  # GET /hr/salaries/1/edit
  def edit
    @people = @hr_salary.hr_person.fdn_organization.people
  end

  # POST /hr/salaries
  # POST /hr/salaries.json
  def create
    @hr_salary = Hr::Salary.new(hr_salary_params)

    respond_to do |format|
      if @hr_salary.save
        format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'hr/salaries', :action => :detail_refresh), {org_id: @hr_salary.hr_ent_talent.ent.organization.id, year: @hr_salary.year, month: @hr_salary.month}, '工资创建成功！') }
        format.json { render :show, status: :created, location: @hr_salary }
      else
        format.html { render :new }
        format.json { render json: @hr_salary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hr/salaries/1
  # PATCH/PUT /hr/salaries/1.json
  def update
    respond_to do |format|
      if @hr_salary.update(hr_salary_params)
        format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'hr/salaries', :action => :detail_refresh), {org_id: @hr_salary.hr_ent_talent.ent.organization.id, year: @hr_salary.year, month: @hr_salary.month}, '工资修改成功！') }
        format.json { render :show, status: :ok, location: @hr_salary }
      else
        format.html { render :edit }
        format.json { render json: @hr_salary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hr/salaries/1
  # DELETE /hr/salaries/1.json
  def destroy
    @hr_salary.destroy
    respond_to do |format|
      format.html { redirect_to hr_salaries_url, notice: 'Salary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hr_salary
    @hr_salary = Hr::Salary.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hr_salary_params
    params.require(:hr_salary).permit!
  end
end
