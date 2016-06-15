#coding: utf-8
class Hr::EntManagersController < ApplicationController
  before_action :set_hr_ent_manager, only: [:show, :edit, :update, :destroy]

  # GET /hr/ent_managers
  # GET /hr/ent_managers.json
  def index
    #@hr_ent_managers = Hr::EntManager.all
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id]
    @org = Fdn::Organization.find @org_id
    if @org.is_ent?
      @hr_ent_managers = Hr::EntManager.by_ent_id(@org.resource_id).paginate(:page => params[:page])
    else
      @hr_ent_managers = []
    end
  end

  # GET /hr/ent_managers/1
  # GET /hr/ent_managers/1.json
  def show
  end

  # GET /hr/ent_managers/new
  def new
    @org = Fdn::Organization.find(params[:org_id])
    @hr_ent_manager = Hr::EntManager.new(ent_id: @org.resource_id)
  end

  # GET /hr/ent_managers/1/edit
  def edit
    @hr_treatment = @hr_ent_manager.treatment.nil? ? @hr_ent_manager.build_treatment(manager_id: @hr_ent_manager.id, ent_id: @hr_ent_manager.ent_id) : @hr_ent_manager.treatment
  end

  # POST /hr/ent_managers
  # POST /hr/ent_managers.json
  def create
    @hr_ent_manager = Hr::EntManager.new(hr_ent_manager_params)

    respond_to do |format|
      if @hr_ent_manager.save
        format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'hr/ent_managers', :action => :detail_refresh), {org_id: @hr_ent_manager.ent.organization.id}, '企业负责人创建成功！') }
        #format.html { redirect_to edit_hr_ent_manager_path(@hr_ent_manager) }
        format.json { render :show, status: :created, location: @hr_ent_manager }
      else
        format.html { render :new }
        format.json { render json: @hr_ent_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hr/ent_managers/1
  # PATCH/PUT /hr/ent_managers/1.json
  def update
    respond_to do |format|
      if @hr_ent_manager.update(hr_ent_manager_params)
        format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'hr/ent_managers', :action => :detail_refresh), {org_id: @hr_ent_manager.ent.organization.id}, '企业负责人修改成功！') }
        format.json { render :show, status: :ok, location: @hr_ent_manager }
      else
        format.html { render :edit }
        format.json { render json: @hr_ent_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hr/ent_managers/1
  # DELETE /hr/ent_managers/1.json
  def destroy
    @hr_ent_manager.destroy
    respond_to do |format|
      format.html { redirect_to hr_ent_managers_url, notice: 'Ent manager was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def detail_refresh
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id]
    @org = Fdn::Organization.find @org_id
    if @org.is_ent?
      @hr_ent_managers = Hr::EntManager.by_ent_id(@org.resource_id).paginate(:page => params[:page])
    else
      @hr_ent_managers = []
    end
  end

  def destroy_record
    @hr_ent_manager = Hr::EntManager.find(params[:id])
    @org_id = @hr_ent_manager.ent.organization.id
    @hr_ent_manager.destroy
    @org = Fdn::Organization.find @org_id
    @hr_ent_managers = Hr::EntManager.by_ent_id(@org.resource_id).paginate(:page => params[:page])
  end

  def show_car
    if !params[:car_id].blank?
      @car = Hr::EntCar.find params[:car_id]
    else
      @car = nil
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hr_ent_manager
    @hr_ent_manager = Hr::EntManager.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hr_ent_manager_params
    params.require(:hr_ent_manager).permit! if params[:hr_ent_manager]
  end
end
