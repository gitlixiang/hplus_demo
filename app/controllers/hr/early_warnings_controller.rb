#coding: utf-8
class Hr::EarlyWarningsController < ApplicationController
  def index
    @years = Cl::year_ary(Hr::Salary, :year)
    @org_id = params[:org_id]||current_org.id
    @org = Fdn::Organization.find @org_id
    @org_name = params[:org_name]||current_org.name
    @year = params[:year]||Time.now.year
    @child = current_org.id == 1 ? '' : params[:child]||'N'
    if @child == 'N'
      budget = Hr::SalaryBudget.find_by(org_id: @org_id, year: @year)
      @budget = budget.gross_salary.to_f.round(2)
      persons = @org.people
      person_ids = persons.map(&:id)
      @salaries = Hr::Salary.persons(person_ids).year(@year)
    else
      budget = Hr::SalaryBudget.orgs(([@org]+@org.all_descendants).map(&:id)).year(@year)
      @budget = budget.sum(:gross_salary).to_f.round(2)
      persons = ([@org]+@org.all_descendants).map { |o| o.people }.flatten
      person_ids = persons.map(&:id)
      @salaries = Hr::Salary.persons(person_ids).year(@year)
    end
    @months = (1..12).to_a.map { |m| m.to_s+'月' } + ['全年预算']
    if current_org.id == 1
      @data = [65297781.94, 62856963.7, 67122876.7, 44710939.66, 50914678.71, 55465555.05, 65652080.14, 48786409.6, 60891798.25, 39094115.42, 72173163.2, 58713616.59, 696419565.5]
      @data_help = [0.0, 65297781.94, 128154745.64, 195277622.34, 239988562.0, 290903240.71, 346368795.76, 412020875.9, 460807285.5, 521699083.75, 560793199.17, 632966362.37, 0]
    else
      @data = (1..12).to_a.map { |m| @salaries.month(m).present? ? @salaries.month(m).sum(:gross_salary).to_f.round(2) : 0 } # + [(1..12).to_a.map { |m| @salaries.month(m).present? ? @salaries.month(m).sum(:gross_salary).to_f.round(2) : 0 }.sum]
      @data << (@data.sum+4739586.54).to_f.round(2)
      @data_help = (1..12).to_a.map { |m| @salaries.month(m).present? ? @salaries.lt_month(m).sum(:gross_salary).to_f.round(2) : 0 } + [0]
    end
    @kinds = %w(基本工资 绩效奖金 加班费 社保 住房公积金 个税 应发工资 应扣金额 实发工资)
    columns = %w(basic_salary pay_for_performance total_overtime_pay social_insurance housing_fund personal_income_tax gross_salary total_deduction net_salary)
    @left = []
    @right = []
    if current_org.id == 1
      @left = [433824855.13, 29407123.83, 228448000.0, 98081394.34, 98126995.74, 38506689.19, 691679978.96, 479363208.68, 212316768.4]
      @right = [653871455.05, 77972034.9, 258663180.72, 295363166.02, 289864730.15, 79948626.41, 990506670.67, 665176522.58, 325330148.09]
    else
      columns.each do |c|
        @left << @salaries.sum(c.to_sym).to_f.round(2)
        if @child == 'N'
          @right << (budget.send(c)||0).to_f.round(2)
        else
          @right << (budget.sum(c.to_sym)||0).to_f.round(2)
        end
      end
    end
    if current_org.id == 1
      @female = [[23, 199835.69], [41, 411645.28], [36, 350379.7], [26, 230847.01], [44, 456475.27], [26, 231830.76], [34, 332196.21], [44, 446827.14], [20, 162296.0], [35, 342889.26], [42, 410224.0], [34, 317433.59], [40, 389322.77], [45, 452181.04], [34, 319610.54], [27, 243679.63], [41, 399907.99], [38, 739675.37], [43, 423972.34], [22, 191195.41], [44, 433879.65], [28, 254144.65], [36, 351028.17], [41, 398026.52], [27, 237641.05]]
      @male = [[33, 318478.81], [21, 174951.5], [28, 261372.66], [27, 247664.41], [33, 309229.28], [33, 307719.84], [37, 353591.94], [33, 311646.47], [33, 314129.27], [40, 386300.6], [25, 223206.5], [23, 198795.91], [35, 339133.47], [34, 331065.11], [28, 254341.45], [23, 197888.7], [39, 759067.87], [45, 450818.74], [38, 370501.39], [45, 458182.04], [36, 353948.19], [32, 302168.76], [45, 441342.91], [44, 453500.84], [37, 354793.28], [21, 171550.63]]
    else
      @male = persons.select { |p| p.sex = 'M' }.sample(40).map { |p| [p.age, Hr::Salary.person(p.id).year(@year).sum(:gross_salary).to_f.round(2)] if Hr::Salary.person(p.id).year(@year).sum(:gross_salary).to_f.round(2) != 0 }.compact
      @female = persons.select { |p| p.sex = 'F' }.sample(40).map { |p| [p.age, Hr::Salary.person(p.id).year(@year).sum(:gross_salary).to_f.round(2)] if Hr::Salary.person(p.id).year(@year).sum(:gross_salary).to_f.round(2) != 0 }.compact
    end
    @line_years = (@year.to_i-4..@year.to_i).to_a
    if current_org.id == 1
      @line_budgets = [1003243474.46, 997177049.6, 1018494005.34, 1006949154.89, 990506670.67]
      @line_salaries = [855174069.58, 811552356.81, 841332678.13, 858564228.29, 891679978.96]
    else
      if @child == 'N'
        @line_budgets = @line_years.map { |year| (a = Hr::SalaryBudget.find_by(org_id: @org_id, year: year)) ? a.gross_salary.to_f.round(2) : 0 } #[14546358.25,14575048.32,15253698.25,15236574.02,17963574.25]#
        ps = @org.people
        pids = ps.map(&:id)
        @line_salaries = @line_years.map { |year| Hr::Salary.persons(pids).year(year).sum(:gross_salary).to_f.round(2) } #[12546358.25,13575048.32,14253698.25,15236574.02,15963574.25]#
      else
        @line_budgets = @line_years.map { |year| Hr::SalaryBudget.orgs(([@org]+@org.all_descendants).map(&:id)).year(year).sum(:gross_salary).to_f.round(2) }
        ps = ([@org]+@org.all_descendants).map { |o| o.people }.flatten
        pids = ps.map(&:id)
        @line_salaries = @line_years.map { |year| Hr::Salary.persons(pids).year(year).sum(:gross_salary).to_f.round(2) }
      end
    end
  end
end
