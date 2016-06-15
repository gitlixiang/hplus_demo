class Hr::PersonHistoriesController < ApplicationController
  before_action :set_hr_person_history, only: [:show, :edit, :update, :destroy]

  # GET /hr/person_histories
  # GET /hr/person_histories.json
  def index
    @people_1 = Hr::Job.category_job()
    @people_9 = Hr::Lookups::MyselfStatus.select_y
    params[:q] = params[:q] ? params[:q] : {}
    @search = Hr::PersonHistory.ransack(params[:q])
    @hr_person_histories = @search.result.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hr_person_histories }
    end
  end

  # GET /hr/person_histories/1
  # GET /hr/person_histories/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hr_person_history }
    end
  end

  # GET /hr/person_histories/new
  def new
    @hr_person_history = Hr::PersonHistory.new
  end

  # GET /hr/person_histories/1/edit
  def edit
  end

  # POST /hr/person_histories
  # POST /hr/person_histories.json
  def create
    @hr_person_history = Hr::PersonHistory.new(hr_person_history_params)

    respond_to do |format|
      if @hr_person_history.save
        format.html { redirect_to @hr_person_history, notice: 'Person history was successfully created.' }
        format.json { render json: @hr_person_history, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @hr_person_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hr/person_histories/1
  # PATCH/PUT /hr/person_histories/1.json
  def update
    respond_to do |format|
      if @hr_person_history.update(hr_person_history_params)
        format.html { redirect_to @hr_person_history, notice: 'Person history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hr_person_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hr/person_histories/1
  # DELETE /hr/person_histories/1.json
  def destroy
    @hr_person_history.destroy
    respond_to do |format|
      format.html { redirect_to hr_person_histories_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hr_person_history
    @hr_person_history = Hr::PersonHistory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hr_person_history_params
    params.require(:hr_person_history).permit!
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
