#coding: utf-8
class Hr::EntTalentsController < ApplicationController
  before_action :set_hr_ent_talent, only: [:show, :edit, :update, :destroy, :check]

  # GET /hr/ent_talents
  # GET /hr/ent_talents.json
  def index
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id]
    @org = Fdn::Organization.find @org_id
    params[:q] = params[:q] ? params[:q] : {}
    @search = Hr::EntTalent.ransack(params[:q])
    if @org.is_ent?
      @hr_ent_talents = @search.result.by_ent_id(@org.resource_id).where(status: 'Y').order('seq').paginate(:page => params[:page])
    else
      @hr_ent_talents = @search.result.where("1=2").paginate(:page => params[:page])
    end
  end

  def change_seq
    change = params[:change]
    @hr_ent_talent = Hr::EntTalent.find(params[:id])
    @hr_ent_talent.change_talent_seq(change)

    respond_to do |format|
      format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'hr/ent_talents', :action => :detail_refresh), {org_id: @hr_ent_talent.ent.organization.id}, '企业人才排序成功！') }
      format.json { render :show, status: :ok, location: @hr_ent_talent }
    end

  end

  def detail_refresh
    @org_id = !params[:org_id].blank? ? params[:org_id] : session[:org_id]
    @org = Fdn::Organization.find @org_id
    @search = Hr::EntTalent.search(params[:q])
    if @org.is_ent?
      @hr_ent_talents = @search.result.by_ent_id(@org.resource_id).where(status: 'Y').order('seq') #.paginate(:page => params[:page])
    else
      @hr_ent_talents = []
    end
  end

  def reviewed_index
    @ent_talents_ntd = Hr::EntTalent.where(status: 'N').paginate(:page => params[:page])
    @ent_talents_fn = Hr::EntTalent.where(status: 'Y').paginate(:page => params[:page])
  end

  def check
    @hr_ent_talent.status = 'Y'
    @hr_ent_talent.save
    redirect_to reviewed_index_hr_ent_talents_path
  end

  def base_index
    @education_type = Hr::Lookups::EducationType.all
    @tal_type = Hr::Lookups::TalType.all
  end

  def search_index
    params[:q] = params[:q] ? params[:q] : {}
    @search = Hr::EntTalent.ransack(params[:q])
    @hr_ent_talents = @search.result.active.order('ent_id, seq').paginate(:page => params[:page])
  end

  def export_list
    if File.exist?(Hr::EntTalent::EXPORT_PATH)
      FileUtils.rm_r(Hr::EntTalent::EXPORT_PATH)
      Dir.mkdir(Hr::EntTalent::EXPORT_PATH)
    else
      Dir.mkdir(Hr::EntTalent::EXPORT_PATH)
    end
    params[:q] = params[:q] ? params[:q] : {}
    @search = Hr::EntTalent.ransack(params[:q])
    @hr_ent_talents = @search.result
    Spreadsheet.client_encoding = "UTF-8"
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    sheet.name = '企业人才花名册'
    sheet.row(0).push "企业人才花名册"
    sheet.merge_cells(0, 0, 0, 10)
    sheet.row(1)[0] = "组织名称"
    sheet.row(1)[1] = "姓名"
    sheet.row(1)[2] = "性别"
    sheet.row(1)[3] = "民族"
    sheet.row(1)[4] = "学历"
    sheet.row(1)[5] = "出生时间"
    sheet.row(1)[6] = "工作时间"
    sheet.row(1)[7] = "籍贯"
    sheet.row(1)[8] = "人才分类"
    sheet.row(1)[9] = "专业技术资质"
    sheet.row(1)[10] = "联系方式"
    i = 2
    @hr_ent_talents.each do |m|
      sheet.row(i)[0] = m.ent_name
      sheet.row(i)[1] = m.name
      sheet.row(i)[2] = m.sex == 'F' ? '女' : '男'
      sheet.row(i)[3] = m.nationality.value if m.nationality
      sheet.row(i)[4] = m.education_type.value if m.education_type
      sheet.row(i)[5] = m.birthday.blank? ? '' : m.birthday.strftime('%Y.%m').to_s
      sheet.row(i)[6] = m.work_date.blank? ? '' : m.work_date.strftime('%Y.%m').to_s
      sheet.row(i)[7] = m.native_place_code
      sheet.row(i)[8] = m.tal_type.value if m.tal_type
      sheet.row(i)[9] = m.pro_tech_qua
      sheet.row(i)[10] = m.phone
      i += 1
    end
    path = "#{Hr::EntTalent::EXPORT_PATH}/企业人才花名册.xls"
    book.write path
    send_file path
  end

  def analysis_index
    params[:q] = params[:q] ? params[:q] : {}
    @search = Hr::EntTalent.search(params[:q])
    @hr_ent_talents = @search.result

    #人才学历情况分析
    @education_type = Hr::Lookups::EducationType.all
    arr_education = []
    @education_type.each do |et|
      edu_count = @hr_ent_talents.where(education: et.code).size
      arr_education << [et.value, edu_count || 0]
    end
    @chart_edu = pie_part(arr_education, 243, "人才学历情况分析")

    #人才分类情况分析
    @tal_type = Hr::Lookups::TalType.all
    arr_tal = []
    @tal_type.each do |tt|
      tal_count = @hr_ent_talents.where(type_code: tt.code).size
      arr_tal << [tt.value, tal_count || 0]
    end
    @chart_tal = pie_part(arr_tal, 243, "人才分类情况分析")

    #人才性别情况分析
    @sex_m = @hr_ent_talents.where(sex: 'M').count
    @sex_f = @hr_ent_talents.where(sex: 'F').count
    arr_sex = []
    arr_sex << ["男", @sex_m || 0]
    arr_sex << ["女", @sex_f || 0]
    @chart_sex = pie_part(arr_sex, 243, "人才性别情况分析")

    #人才年龄层次情况分析
    arr_age = [[0, 30, '30岁以下'], [30, 40, '30~40岁'], [40, 50, '40~50岁'], [50, 60, '50~60岁'], [60, 1000, '60岁以上']]
    arr_age_type = []
    arr_age.each do |age|
      date_start = (Time.now - age[1].years).strftime('%Y-%m-%d')
      date_end = (Time.now - age[0].years).strftime('%Y-%m-%d')
      @age_count = @hr_ent_talents.where("birthday > ? and birthday <= ?", date_start, date_end).count
      arr_age_type << [age[2], @age_count || 0]
    end
    @chart_age =pie_part(arr_age_type, 243, "人才年龄层次情况分析")
  end

  # GET /hr/ent_talents/1
  # GET /hr/ent_talents/1.json
  def show
  end

  # GET /hr/ent_talents/new
  def new
    seq = Hr::EntTalent.where(ent_id: params[:ent_id]).map(&:seq).max || 0
    @hr_ent_talent = Hr::EntTalent.new(ent_id: params[:ent_id], seq: seq+1)
  end

  # GET /hr/ent_talents/1/edit
  def edit
  end

  # POST /hr/ent_talents
  # POST /hr/ent_talents.json
  def create
    @hr_ent_talent = Hr::EntTalent.new(hr_ent_talent_params)

    respond_to do |format|
      if @hr_ent_talent.save
        format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'hr/ent_talents', :action => :detail_refresh), {org_id: @hr_ent_talent.ent.organization.id}, '企业人才创建成功！') }
        #format.html { render :js => view_context.close_window_show_tips('parent.MAIN_LAYER_WINDOW','企业人才创建成功！') }
        format.json { render :show, status: :created, location: @hr_ent_talent }
      else
        format.html { render :new }
        format.json { render json: @hr_ent_talent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hr/ent_talents/1
  # PATCH/PUT /hr/ent_talents/1.json
  def update
    respond_to do |format|
      if @hr_ent_talent.update(hr_ent_talent_params)
        format.html { render :js => view_context.close_window_refresh_div_show_tips('parent.MAIN_LAYER_WINDOW', url_for(:controller => 'hr/ent_talents', :action => :detail_refresh), {org_id: @hr_ent_talent.ent.organization.id}, '企业人才创建成功！') }
        format.json { render :show, status: :ok, location: @hr_ent_talent }
      else
        format.html { render :edit }
        format.json { render json: @hr_ent_talent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hr/ent_talents/1
  # DELETE /hr/ent_talents/1.json
  def destroy
    @hr_ent_talent.destroy
    respond_to do |format|
      format.html { redirect_to hr_ent_talents_url, notice: '企业人才删除成功！' }
      format.json { head :no_content }
    end
  end

  private
  #饼图
  def pie_part(arr, width, attr_name)
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => attr_name)
      f.series({
                   type: 'pie',
                   name: attr_name,
                   data: arr
               })
      f.plotOptions({
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            dataLabels: {
                                enabled: true,
                                color: '#000000',
                                connectorColor: '#000000',
                                format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                            }
                        }
                    })
      f.chart({
                  plotBackgroundColor: nil,
                  plotBorderWidth: nil,
                  plotShadow: false
              })
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_hr_ent_talent
    @hr_ent_talent = Hr::EntTalent.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hr_ent_talent_params
    params.require(:hr_ent_talent).permit! if params[:hr_ent_talent]
  end
end
