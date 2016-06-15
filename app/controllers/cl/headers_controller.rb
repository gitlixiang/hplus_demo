#coding: utf-8
class Cl::HeadersController < ApplicationController
  before_action :set_cl_header, only: [:show, :edit, :update, :destroy, :set_content, :get_content]

  # GET /cl/headers
  # GET /cl/headers.json
  def index
    @cl_headers = Cl::Header.all
  end

  # GET /cl/headers/1
  # GET /cl/headers/1.json
  def show
  end

  # GET /cl/headers/new
  def new
    @cl_header = Cl::Header.new
  end

  # GET /cl/headers/1/edit
  def edit
  end

  #设置表头内容
  def set_content
    # ary = [['','工资单','','',''],%w(基本工资 绩效工资 年终奖 社保 公积金)]+Array.new(3,Array.new(5,''))
    @cl_header = Cl::Header.find(1)
    @data = @cl_header.data||Array.new(5, Array.new(5, ''))
    merges = @cl_header.merges
    aligns = @cl_header.aligns
    comments = @cl_header.comments
    @merges = merges ? merges.gsub(':', '').gsub('=>', ':') : []
    @aligns= aligns ? aligns.gsub(':', '').gsub('=>', ':') : []
    @comments = comments ? comments.gsub(':', '').gsub('=>', ':') : []
    # @merges = merges ? merges : []
    # @aligns= aligns ? aligns : []
    # @comments = comments ? comments : []
  end

  def get_content
    p params[:data]
    p params[:merge_result]
    p params[:align_result]
    p params[:comment_result]
    p '================'
    p params[:data].map { |m| ActiveSupport::JSON.decode(m) }
    p params[:merge_result].map { |m| ActiveSupport::JSON.decode(m) }
    p params[:align_result].map { |m| ActiveSupport::JSON.decode(m) }
    p params[:comment_result].map { |m| ActiveSupport::JSON.decode(m) }
    # data = params[:data].map { |row| ('@,'+row+',@').split(',')[1..-2] }
    # merge = params[:merge_result].map { |m| ActiveSupport::JSON.decode(m) }.map(&:deep_symbolize_keys)
    # align = params[:align_result].map { |m| ActiveSupport::JSON.decode(m) }.keep_if { |ha| ha.has_key?('className') }.map(&:deep_symbolize_keys)
    # comment = params[:comment_result].map { |m| ActiveSupport::JSON.decode(m) }.keep_if { |ha| ha.has_key?('comment') }.map(&:deep_symbolize_keys)
    data = params[:data].map { |row| ('@,'+row+',@').split(',')[1..-2] }
    merge = params[:merge_result].map { |m| ActiveSupport::JSON.decode(m) }.map(&:deep_symbolize_keys)
    align = params[:align_result].map { |m| ActiveSupport::JSON.decode(m) }.keep_if { |ha| ha.has_key?('className') }.map(&:deep_symbolize_keys)
    comment = params[:comment_result].map { |m| ActiveSupport::JSON.decode(m) }.keep_if { |ha| ha.has_key?('comment') }.map(&:deep_symbolize_keys)
    # cells = params[:cells].map { |m| ActiveSupport::JSON.decode(m) }.map(&:deep_symbolize_keys)
    if true #@cl_header.update_attributes(data: data, merges: merge, aligns: align, comments: comment)
      respond_to do |format|
        format.js
      end
    end
  end

  def download_table
    name = params[:name].blank? ? '表格' : params[:name]
    dir_path = Rails.root.join('tmp', current_user.id.to_s).to_s
    Dir.mkdir(dir_path.to_s) unless Dir.exist?(dir_path)
    path = Rails.root.join('tmp', current_user.id.to_s, "#{name}.xls")
    File.delete(path) if File.exist?(path)
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => name
    params[:data].each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        sheet.row(row_index).insert col_index, cell
      end
    end
    book.write path
    respond_to do |format|
      @java_url = ajax_download_cl_headers_path(name: name)
      format.js { render :partial => 'downloadFile' }
    end
  end

  def ajax_download
    name = params[:name]
    path = Rails.root.join('tmp', current_user.id.to_s, "#{name}.xls")
    send_file path
  end

  # POST /cl/headers
  # POST /cl/headers.json
  def create
    @cl_header = Cl::Header.new(cl_header_params)

    respond_to do |format|
      if @cl_header.save
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '表头创建成功！') }
        format.json { render :show, status: :created, location: @cl_header }
      else
        format.html { render :new }
        format.json { render json: @cl_header.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cl/headers/1
  # PATCH/PUT /cl/headers/1.json
  def update
    respond_to do |format|
      if @cl_header.update(cl_header_params)
        format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW', '表头修改成功！') }
        format.json { render :show, status: :ok, location: @cl_header }
      else
        format.html { render :edit }
        format.json { render json: @cl_header.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cl/headers/1
  # DELETE /cl/headers/1.json
  def destroy
    @cl_header.destroy
    respond_to do |format|
      format.html { redirect_to cl_headers_url, notice: 'Header was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_cl_header
    @cl_header = Cl::Header.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cl_header_params
    params.require(:cl_header).permit(:name, :resource_type, :code, :order)
  end
end
