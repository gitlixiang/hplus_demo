#coding: utf-8
class Fdn::LoggersController < ApplicationController
  # GET /fdn/loggers
  # GET /fdn/loggers.json
  def index
    #导入代码
    #require 'spreadsheet'
    #Spreadsheet.client_encoding = "UTF-8"
    #path = Rails.root.join('public', 'water.xls')
    #book = Spreadsheet.open path
    #sheet = book.worksheet(0)
    #sheet.each 1 do |row|
    #  #判断组织机构代码
    #  if Fdn::Organization.where("code = ?", row[1]).size != 0
    #    @org = Fdn::Organization.where("code = ?", row[1]).first
    #    @ent = @org.resource
    #    #同步数据
    #    @ent.ent_code = row[1]
    #    @ent.ent_level_code = row[3]
    #    @ent.save
    #    @org.name = row[2]
    #    @org.short_name = row[2]
    #    @org.code = row[1]
    #    @org.save
    #    #更新history表
    #    @ent.update_history
    #  else
    #    @ent = Fdn::Enterprise.new
    #    @org = @ent.build_organization
    #    #同步数据
    #    @ent.ent_code = row[1]
    #    @ent.ent_level_code = row[3]
    #    @ent.start_time = "2011-12-31 23:59:59"
    #    @org.name = row[2]
    #    @org.short_name = row[2]
    #    @org.code = row[1]
    #    @ent.save
    #    #增加到企业树结构
    #    #@parent_org.with_hierarchy.add_child(@org.id, nil, nil)
    #    #创建history表
    #    @ent_his = Fdn::EnterpriseHistory.new
    #    @ent_his.start_time = "2011-12-31 23:59:59"
    #    @ent_his.copy_data(@ent)
    #  end
    #end
    #path2 = Rails.root.join('public', 'water_tree.xls')
    #book2 = Spreadsheet.open path2
    #sheet2 = book2.worksheet(0)
    #sheet2.each do |row|
    #  @child_org = Fdn::Organization.where("code = ?", row[3]).first
    #  @parent_org = Fdn::Organization.where("code = ?", row[4]).first
    #  if @child_org.with_hierarchy.parent.nil?
    #    @parent_org.with_hierarchy.add_child(@child_org.id, nil, nil)
    #  end
    #end
    #Fdn::OrgTreeChange.create(hierarchy_id:1,change_time:Time.now)
    #p '################'
    #p arr
    params[:q] = params[:q] ? params[:q] : {}
    date_to_end_time(params[:q], [:act_at_lteq])
    @search = Fdn::Logger.search(params[:q])
    @fdn_loggers = @search.result.more_search(params[:q], params[:page]||1)
  end

  # GET /fdn/loggers/1
  # GET /fdn/loggers/1.json
  def show
    @fdn_logger = Fdn::Logger.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fdn_logger }
    end
  end

  # GET /fdn/loggers/new
  # GET /fdn/loggers/new.json
  def new
    @fdn_logger = Fdn::Logger.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fdn_logger }
    end
  end

  # GET /fdn/loggers/1/edit
  def edit
    @fdn_logger = Fdn::Logger.find(params[:id])
  end

  # POST /fdn/loggers
  # POST /fdn/loggers.json
  def create
    @fdn_logger = Fdn::Logger.new(params[:fdn_logger])

    respond_to do |format|
      if @fdn_logger.save
        format.html { redirect_to @fdn_logger, notice: 'Logger was successfully created.' }
        format.json { render json: @fdn_logger, status: :created, location: @fdn_logger }
      else
        format.html { render action: "new" }
        format.json { render json: @fdn_logger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fdn/loggers/1
  # PUT /fdn/loggers/1.json
  def update
    @fdn_logger = Fdn::Logger.find(params[:id])

    respond_to do |format|
      if @fdn_logger.update_attributes(params[:fdn_logger])
        format.html { redirect_to @fdn_logger, notice: 'Logger was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fdn_logger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fdn/loggers/1
  # DELETE /fdn/loggers/1.json
  def destroy
    @fdn_logger = Fdn::Logger.find(params[:id])
    @fdn_logger.destroy

    respond_to do |format|
      format.html { redirect_to fdn_loggers_url }
      format.json { head :no_content }
    end
  end

  def show_info
    @user = Fdn::User.find params[:id]
    render :layout => 'form'
  end
end
