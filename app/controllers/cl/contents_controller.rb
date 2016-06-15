class Cl::ContentsController < ApplicationController
  before_action :set_cl_content, only: [:show, :edit, :update, :destroy]

  # GET /cl/contents
  # GET /cl/contents.json
  def index
    @cl_contents = Cl::Content.all
  end

  # GET /cl/contents/1
  # GET /cl/contents/1.json
  def show
  end

  # GET /cl/contents/new
  def new
    @cl_content = Cl::Content.new
  end

  # GET /cl/contents/1/edit
  def edit
  end

  # POST /cl/contents
  # POST /cl/contents.json
  def create
    @cl_content = Cl::Content.new(cl_content_params)

    respond_to do |format|
      if @cl_content.save
        format.html { redirect_to @cl_content, notice: 'Content was successfully created.' }
        format.json { render :show, status: :created, location: @cl_content }
      else
        format.html { render :new }
        format.json { render json: @cl_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cl/contents/1
  # PATCH/PUT /cl/contents/1.json
  def update
    respond_to do |format|
      if @cl_content.update(cl_content_params)
        format.html { redirect_to @cl_content, notice: 'Content was successfully updated.' }
        format.json { render :show, status: :ok, location: @cl_content }
      else
        format.html { render :edit }
        format.json { render json: @cl_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cl/contents/1
  # DELETE /cl/contents/1.json
  def destroy
    @cl_content.destroy
    respond_to do |format|
      format.html { redirect_to cl_contents_url, notice: 'Content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_cl_content
    @cl_content = Cl::Content.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cl_content_params
    params.require(:cl_content).permit(:name, :row, :col, :rows, :cols, :code, :header_id)
  end
end
