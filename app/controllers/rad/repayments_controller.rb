class Rad::RepaymentsController < ApplicationController
  before_action :set_rad_repayment, only: [:show, :edit, :update, :destroy]

  # GET /rad/repayments
  # GET /rad/repayments.json
  def index
    @rad_repayments = Rad::Repayment.by_bond_id(params[:cor_bond_id]).order("repay_date DESC")
  end

  # GET /rad/repayments/1
  # GET /rad/repayments/1.json
  def show
  end

  # GET /rad/repayments/new
  def new
    @rad_repayment = Rad::Repayment.new(cor_bond_id: params[:cor_bond_id])
  end

  # GET /rad/repayments/1/edit
  def edit
  end

  # POST /rad/repayments
  # POST /rad/repayments.json
  def create
    @rad_repayment = Rad::Repayment.new(rad_repayment_params)

    respond_to do |format|
      if @rad_repayment.save
        format.html { redirect_to rad_repayments_path(cor_bond_id: @rad_repayment.cor_bond_id), notice: 'Repayment was successfully created.' }
        format.json { render :show, status: :created, location: @rad_repayment }
      else
        format.html { render :new }
        format.json { render json: @rad_repayment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rad/repayments/1
  # PATCH/PUT /rad/repayments/1.json
  def update
    respond_to do |format|
      if @rad_repayment.update(rad_repayment_params)
        format.html { redirect_to rad_repayments_path(cor_bond_id: @rad_repayment.cor_bond_id), notice: 'Repayment was successfully updated.' }
        format.json { render :show, status: :ok, location: @rad_repayment }
      else
        format.html { render :edit }
        format.json { render json: @rad_repayment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rad/repayments/1
  # DELETE /rad/repayments/1.json
  def destroy
    @rad_repayment.destroy
    respond_to do |format|
      format.html { redirect_to rad_repayments_url, notice: 'Repayment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rad_repayment
    @rad_repayment = Rad::Repayment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rad_repayment_params
    params.require(:rad_repayment).permit! if params[:rad_repayment]
  end
end
