class Pm::CommentsController < ApplicationController
  before_action :set_pm_comment, only: [:show, :edit, :update, :destroy]

  # GET /pm/comments
  # GET /pm/comments.json
  def index
    @pm_comments = Pm::Comment.all
  end

  # GET /pm/comments/1
  # GET /pm/comments/1.json
  def show
  end

  # GET /pm/comments/new
  def new
    @pm_comment = Pm::Comment.new
  end

  # GET /pm/comments/1/edit
  def edit
  end

  # POST /pm/comments
  # POST /pm/comments.json
  def create
    @pm_comment = Pm::Comment.new(pm_comment_params)

    respond_to do |format|
      if @pm_comment.save
        format.html { redirect_to @pm_comment.resource }
        format.json { render :show, status: :created, location: @pm_comment }
      else
        format.html { render :new }
        format.json { render json: @pm_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def super_create

  end

  # PATCH/PUT /pm/comments/1
  # PATCH/PUT /pm/comments/1.json
  def update
    respond_to do |format|
      if @pm_comment.update(pm_comment_params)
        format.html { redirect_to @pm_comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @pm_comment }
      else
        format.html { render :edit }
        format.json { render json: @pm_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pm/comments/1
  # DELETE /pm/comments/1.json
  def destroy
    @pm_comment.destroy
    respond_to do |format|
      format.html { redirect_to pm_comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pm_comment
    @pm_comment = Pm::Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pm_comment_params
    params.require(:pm_comment).permit(:content, :comment_time, :user_id, :resource_id, :resource_type, :resource)
  end
end
