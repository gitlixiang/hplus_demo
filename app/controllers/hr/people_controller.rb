#coding: utf-8
class Hr::PeopleController < ApplicationController
  before_action :set_hr_person, only: [:show, :edit, :update, :destroy, :change_seat]

  # GET /hr/people
  # GET /hr/people.json
  def index
    @people_1 = Hr::Job.category_job()
    @people_9 = Hr::Lookups::MyselfStatus.select_y
    params[:q] = params[:q] ? params[:q] : {}
    @search = Hr::Person.ransack(params[:q])
    @hr_people = @search.result.paginate(:page => params[:page])
  end

  def export_index
    @search = Hr::Person.ransack(params[:q])
    @hr_people = @search.result
    file_name = '企业人员变动情况'
    dir_path = Rails.root.join('tmp', current_user.id.to_s).to_s
    Dir.mkdir(dir_path.to_s) unless Dir.exist?(dir_path)
    path = Rails.root.join('tmp', current_user.id.to_s, "#{file_name}.xls")
    File.delete(path) if File.exist?(path)
    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    sheet.name = '企业人员变动情况'
    columns = Hr::Person.column_names.reject { |name| ['id', 'created_by', 'updated_by', 'created_at', 'updated_at'].include?(name) }
    sheet.row(1).replace columns
    @hr_people.each_with_index do |person, index|
      sheet.row(index+2).replace columns.map { |column| person.send(column.to_sym) }
    end
    book.write path
    send_file path
  end

  #职务变更
  def change_seat
    init_select
  end

  # GET /hr/people/1
  # GET /hr/people/1.json
  def show
  end

  # GET /hr/people/new
  def new
    @hr_person = Hr::Person.new
    init_select
  end

  # GET /hr/people/1/edit
  def edit
    init_select
  end

  # POST /hr/people
  # POST /hr/people.json
  def create
    @hr_person = Hr::Person.new(hr_person_params)

    respond_to do |format|
      if @hr_person.save
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '资料修改成功！') }
        format.json { render :show, status: :created, location: @hr_person }
      else
        format.html { render :new }
        format.json { render json: @hr_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hr/people/1
  # PATCH/PUT /hr/people/1.json
  def update
    respond_to do |format|
      old = @hr_person
      if @hr_person.update(hr_person_params)
        if params[:change_seat]
          @hr_person.hr_person_histories.create(old.attributes.except('id', 'created_by', 'updated_by', 'created_at', 'updated_at'))
        end
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '资料创建成功！') }
        format.json { render :show, status: :ok, location: @hr_person }
      else
        format.html { render :edit }
        format.json { render json: @hr_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hr/people/1
  # DELETE /hr/people/1.json
  def destroy
    @hr_person.destroy
    respond_to do |format|
      format.html { redirect_to hr_people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hr_person
    @hr_person = Hr::Person.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hr_person_params
    params.require(:hr_person).permit!
  end

  def init_select
    @people_0 = Hr::Lookups::AssessesClass.select_y
    @people_1 = Hr::Job.category_job()
    @people_2 = Hr::Person::SEX
    @people_3 = Fdn::Lookups::Nationality.select_y
    @people_4 = [] #Fdn::Region.category_region()
    @people_5 = Hr::Lookups::PoliticalLandscapeCode.select_y
    @people_6 = Hr::Lookups::StateHealth.state_health()
    @people_7 = Hr::JobLevel.category_joblevel
    @people_8 = Hr::Lookups::PreparationClass.select_y
    @people_9 = Hr::Lookups::MyselfStatus.select_y
    @people_10 = Hr::Lookups::DegreeCode.degree_people()
    @people_11 = Hr::Lookups::JobStatusCode.select_y
    @people_12 = Hr::Lookups::CategoryPerson.category_person()
    @people_13 = Hr::Lookups::CadresCategoryCode.select_y
    @people_14 = Hr::Lookups::DeptId.select_y
    @people_15 = Hr::Lookups::EntryWaysCode.entry_way()
    @people_16 = Hr::Lookups::DemobClassCode.select_y
    @people_17 = Fdn::ONE_OR_ZERO
    @people_18 = Fdn::ONE_OR_ZERO
    @people_19 = Hr::Lookups::MedicalInsuranceCode.select_y
    @people_20 = Hr::Lookups::EndowmentInsuranceCode.select_y
    @people_21 = Hr::Lookups::PfCategoryCode.select_y
  end
end
