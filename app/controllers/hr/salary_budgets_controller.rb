#coding: utf-8
class Hr::SalaryBudgetsController < ApplicationController
  before_action :set_hr_salary_budget, only: [:show, :edit, :update, :destroy]

  def salary_submit
    @hr_salary_budgets = Hr::SalaryBudget.org(current_org.id)
  end

  def salary_review
    @hr_salary_budgets = Hr::SalaryBudget.orgs(current_org.children.map(&:id))
  end

  def salary_record
    @hr_salary_budgets = Hr::SalaryBudget.orgs(current_org.all_descendants.map(&:id))
  end

  # GET /hr/salary_budgets
  # GET /hr/salary_budgets.json
  def index
    @years = Cl::year_ary(Hr::Salary, :year)
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id].to_s
    @hr_salary_budget = Hr::SalaryBudget.org(@org_id).year(params[:year]).first
  end

  def detail_refresh
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id].to_s
    @hr_salary_budget = Hr::SalaryBudget.org(@org_id).year(params[:year]).first
  end

  # GET /hr/salary_budgets/1
  # GET /hr/salary_budgets/1.json
  def show
    # @workflow = @hr_salary_budget.wf_simple_workflow
  end

  # GET /hr/salary_budgets/new
  def new
    @years = Cl::year_ary(Hr::Salary, :year)
    @hr_salary_budget = Hr::SalaryBudget.new(org_id: params[:org_id], year: params[:year])
  end

  # GET /hr/salary_budgets/1/edit
  def edit
    @years = Cl::year_ary(Hr::Salary, :year)
  end

  # POST /hr/salary_budgets
  # POST /hr/salary_budgets.json
  def create
    @hr_salary_budget = Hr::SalaryBudget.new(hr_salary_budget_params)

    respond_to do |format|
      if @hr_salary_budget.save
        # @hr_salary_budget.build_wf_simple_workflow
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '工资预算创建成功！') }
        # format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'hr/salary_budgets', :action => :detail_refresh), {org_id: @hr_salary_budget.org_id, year: @hr_salary_budget.year}, '工资预算创建成功！') }
        format.json { render :show, status: :created, location: @hr_salary_budget }
      else
        @years = Cl::year_ary(Hr::Salary, :year)
        format.html { render :new }
        format.json { render json: @hr_salary_budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hr/salary_budgets/1
  # PATCH/PUT /hr/salary_budgets/1.json
  def update
    respond_to do |format|
      if @hr_salary_budget.update(hr_salary_budget_params)
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '工资预算更新成功！') }
        # format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'hr/salary_budgets', :action => :detail_refresh), {org_id: @hr_salary_budget.org_id, year: @hr_salary_budget.year}, '工资预算创建成功！') }
        format.json { render :show, status: :ok, location: @hr_salary_budget }
      else
        format.html { render :edit }
        format.json { render json: @hr_salary_budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hr/salary_budgets/1
  # DELETE /hr/salary_budgets/1.json
  def destroy
    @hr_salary_budget.destroy
    respond_to do |format|
      format.html { redirect_to hr_salary_budgets_url, notice: 'Salary budget was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hr_salary_budget
    @hr_salary_budget = Hr::SalaryBudget.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hr_salary_budget_params
    params.require(:hr_salary_budget).permit!
  end
end
