#coding: utf-8
class Fdn::LookupsController < ApplicationController
  before_action :set_fdn_lookup, only: [:show, :edit, :update, :destroy]
  # GET /fdn/lookups
  # GET /fdn/lookups.json
  def index
    params[:q] = params[:q] ? params[:q] : {}
    date_to_end_time(params[:q], [:act_at_lteq])
    @search = Fdn::Lookup.search(params[:q])
    @fdn_lookups = @search.result.more_search(params[:q], params[:page]||1)
  end

  # GET /fdn/lookups/1
  # GET /fdn/lookups/1.json
  def show
    @fdn_lookup = Fdn::Lookup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fdn_lookup }
    end
  end

  # GET /fdn/lookups/new
  # GET /fdn/lookups/new.json
  def new
    @fdn_lookup = Fdn::Lookup.new #(type:params[:type],type_name:params[:type_name])
    @fdn_lookup.type = params[:type]
    @fdn_lookup.type_name = params[:type_name]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fdn_lookup }
    end
  end

  # GET /fdn/lookups/1/edit
  def edit
    @fdn_lookup = Fdn::Lookup.find(params[:id])
  end

  # POST /fdn/lookups
  # POST /fdn/lookups.json
  def create
    @fdn_lookup = Fdn::Lookup.new(fdn_lookup_params)
    @fdn_lookup.type = params[:type]
    respond_to do |format|
      if @fdn_lookup.save
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '创建成功！') }
        format.json { render json: @fdn_lookup, status: :created, location: @fdn_lookup }
      else
        #format.html { redirect_to(new_fdn_lookup_path(fdn_lookup_params),alert: @fdn_lookup.errors.to_s) }
        format.html { render action: "new" }
        format.json { render json: @fdn_lookup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fdn/lookups/1
  # PUT /fdn/lookups/1.json
  def update
    @fdn_lookup = Fdn::Lookup.find(params[:id])

    respond_to do |format|
      if @fdn_lookup.update_attributes(fdn_lookup_params)
        format.html { redirect_to @fdn_lookup, notice: 'Lookup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fdn_lookup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fdn/lookups/1
  # DELETE /fdn/lookups/1.json
  def destroy
    @fdn_lookup = Fdn::Lookup.find(params[:id])
    @fdn_lookup.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_fdn_lookup
    @fdn_lookup = Fdn::Lookup.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def fdn_lookup_params
    params.require(:fdn_lookup).permit! if params[:fdn_lookup]
    # params.require(:fdn_lookup).permit(:org_id, :type_code, :title, :content, :file_resources_attributes => [:filename, :ffx,:display_name,:],:file_attributes => [:filename, :ffx,:display_name])
  end

end
