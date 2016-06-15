class Pm::NodesController < ApplicationController
  before_action :set_pm_node, only: [:show, :edit, :update, :destroy]

  # GET /pm/nodes
  # GET /pm/nodes.json
  def index
    @pm_nodes = Pm::Node.all
  end

  # GET /pm/nodes/1
  # GET /pm/nodes/1.json
  def show
  end

  # GET /pm/nodes/new
  def new
    @pm_node = Pm::Node.new
  end

  # GET /pm/nodes/1/edit
  def edit
  end

  # POST /pm/nodes
  # POST /pm/nodes.json
  def create
    @pm_node = Pm::Node.new(pm_node_params)

    respond_to do |format|
      if @pm_node.save
        format.html { redirect_to @pm_node, notice: 'Node was successfully created.' }
        format.json { render :show, status: :created, location: @pm_node }
      else
        format.html { render :new }
        format.json { render json: @pm_node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pm/nodes/1
  # PATCH/PUT /pm/nodes/1.json
  def update
    respond_to do |format|
      if @pm_node.update(pm_node_params)
        format.html { redirect_to @pm_node, notice: 'Node was successfully updated.' }
        format.json { render :show, status: :ok, location: @pm_node }
      else
        format.html { render :edit }
        format.json { render json: @pm_node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pm/nodes/1
  # DELETE /pm/nodes/1.json
  def destroy
    @pm_node.destroy
    respond_to do |format|
      format.html { redirect_to pm_nodes_url, notice: 'Node was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pm_node
    @pm_node = Pm::Node.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pm_node_params
    params.require(:pm_node).permit(:percent, :content, :name, :plan_id, :sort_seq, :start_date, :end_date)
  end
end
