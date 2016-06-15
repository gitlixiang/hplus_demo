#coding: utf-8
class Hr::EntCarsController < ApplicationController
  before_action :set_hr_ent_car, only: [:show, :edit, :update, :destroy]

  # GET /hr/ent_cars
  # GET /hr/ent_cars.json
  def index
    #@hr_ent_cars = Hr::EntCar.all
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id]
    @org = Fdn::Organization.find @org_id
    if @org.is_ent?
      @hr_ent_cars = Hr::EntCar.by_ent_id(@org.resource_id).paginate(:page => params[:page])
    else
      @hr_ent_cars = []
    end
  end

  # GET /hr/ent_cars/1
  # GET /hr/ent_cars/1.json
  def show
  end

  # GET /hr/ent_cars/new
  def new
    @org = Fdn::Organization.find(params[:org_id])
    @hr_ent_car = Hr::EntCar.new(ent_id: @org.resource_id)
  end

  # GET /hr/ent_cars/1/edit
  def edit
  end

  # POST /hr/ent_cars
  # POST /hr/ent_cars.json
  def create
    @hr_ent_car = Hr::EntCar.new(hr_ent_car_params)

    respond_to do |format|
      if @hr_ent_car.save
        format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'hr/ent_cars', :action => :detail_refresh), {org_id: @hr_ent_car.ent.organization.id}, '车辆创建成功！') }
        format.json { render :show, status: :created, location: @hr_ent_car }
      else
        format.html { render :new }
        format.json { render json: @hr_ent_car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hr/ent_cars/1
  # PATCH/PUT /hr/ent_cars/1.json
  def update
    respond_to do |format|
      if @hr_ent_car.update(hr_ent_car_params)
        format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'hr/ent_cars', :action => :detail_refresh), {org_id: @hr_ent_car.ent.organization.id}, '车辆修改成功！') }
        format.json { render :show, status: :ok, location: @hr_ent_car }
      else
        format.html { render :edit }
        format.json { render json: @hr_ent_car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hr/ent_cars/1
  # DELETE /hr/ent_cars/1.json
  def destroy
    @hr_ent_car.destroy
    respond_to do |format|
      format.html { redirect_to hr_ent_cars_url, notice: 'Ent car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def detail_refresh
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id]
    @org = Fdn::Organization.find @org_id
    if @org.is_ent?
      @hr_ent_cars = Hr::EntCar.by_ent_id(@org.resource_id).paginate(:page => params[:page])
    else
      @hr_ent_cars = []
    end
  end

  def destroy_record
    @hr_ent_car = Hr::EntCar.find(params[:id])
    @org_id = @hr_ent_car.ent.organization.id
    @hr_ent_car.destroy
    @org = Fdn::Organization.find @org_id
    @hr_ent_cars = Hr::EntCar.by_ent_id(@org.resource_id).paginate(:page => params[:page])
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hr_ent_car
    @hr_ent_car = Hr::EntCar.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hr_ent_car_params
    params.require(:hr_ent_car).permit! if params[:hr_ent_car]
  end
end
