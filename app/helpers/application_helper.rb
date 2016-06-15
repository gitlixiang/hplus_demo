#coding:utf-8
module ApplicationHelper
  #计算序号
  #collection: 集合
  #obj: 集合中的元素
  #per_page: 每页显示记录数
  def seq(collection, obj, p_page, p_per_page=nil)
    if p_per_page.nil?
      per_page = Fdn::Lookup::PAGE_PER_COUNT
    else
      per_page = p_per_page
    end

    page = p_page.to_i
    if page < 1
      page = 1
    end

    (page - 1) * per_page + collection.index(obj) + 1
  end

  #去页面配置的assets
  #可以在config/settings中配置页面的asset js css文件
  def view_assets_tag
    asset_js_controller = Settings.assets.javascript.send(params[:controller]).nil? ? nil : Settings.assets.javascript.send(params[:controller]).send(:all)
    asset_css_controller = Settings.assets.css.send(params[:controller]).nil? ? nil : Settings.assets.css.send(params[:controller]).send(:all)
    asset_js_action = Settings.assets.javascript.send(params[:controller]).nil? ? nil : Settings.assets.javascript.send(params[:controller]).send(params[:action])
    asset_css_action = Settings.assets.css.send(params[:controller]).nil? ? nil : Settings.assets.css.send(params[:controller]).send(params[:action])
    js_files = []
    js_files = js_files + asset_js_controller unless asset_js_controller.nil?
    js_files = js_files + asset_js_action unless asset_js_action.nil?
    css_files = []
    css_files = css_files + asset_css_controller unless asset_css_controller.nil?
    css_files = css_files + asset_css_action unless asset_css_action.nil?
    content = ''
    js_files.each do |js|
      content << javascript_include_tag(js, 'data-turbolinks-track' => true)
    end
    css_files.each do |css|
      content << stylesheet_link_tag(css)
    end
    raw content
  end

  def errors_for(object, message=nil)
    html = ''
    if object && object.errors.present?
      html = alert("#{object.class.model_name.human}：#{I18n.t('activerecord.errors.template.header.other')}", object.errors.full_messages)
    end
    html
  end

  def long_time
    "%Y-%m-%d %H:%M:%S"
  end

  def normal_date
    "%Y-%m-%d"
  end

  def two_decimal(value)
    value.blank? ? '' : sprintf("%.2f", value.to_f)
  end

  #可以传参数的javascript_include_tag
  def javascript_include_tag_with_p(path)
    javascript_tag nil, :src => path
  end

  #截取字符串
  def limit_word(str, limit_length=20)
    truncate(str, :length => limit_length)
  end

  # def html_truncate(html, truncate_length, options={})
  #   text, result = [], []
  #   # get all text (including punctuation) and tags and stick them in a hash
  #   html.scan(/<\/?[^>]*>|[A-Za-z0-9.,\/&#;\!\+\(\)\-"'?]+/).each { |t| text << t }
  #   text.each do |str|
  #     if truncate_length > 0
  #       if str =~ /<\/?[^>]*>/
  #         previous_tag = str
  #         result << str
  #       else
  #         result << str
  #         truncate_length -= str.length
  #       end
  #     else
  #       # now stick the next tag with a  that matches the previous
  #       # open tag on the end of the result
  #       if previous_tag && str =~ /<\/([#{previous_tag}]*)>/
  #         result << str
  #       end
  #     end
  #   end
  #   return result.join(" ") + options[:omission].to_s
  # end

  #用于动态行删除
  def js_remove_line_tag
    rand = Random.new(Time.now.to_i)
    id = rand.rand(1e16).to_i
    #bs_a(confirm: '确认删除吗？',js: "$('##{id.to_s}').parents('tr:first').remove();", id: id.to_s, class: 'fa fa-minus')
    bs_a(js: "if(confirm('确认删除吗？')==true){$('##{id.to_s}').parents('tr:first').remove();} else {return false;}", id: id.to_s, class: 'fa fa-minus')
  end

  #加了删除next， 因为改了ui以后，用fields_for会在tr后面自动生成一个hidden id也要删掉
  def remote_remove_line_tag(f, url)
    rand = Random.new(f.object.object_id + Time.now.to_i)
    id = rand.rand(1e16).to_i
    #puts '==='
    #puts f.object_name
    bs_a(js: "if(confirm('确认删除吗？')==true){$.get('#{url}', {format: 'js'});
          $('##{id.to_s}').parents('tr:first').nextAll('input[name=\"#{f.object_name}[id]\"]').remove();
          $('##{id.to_s}').parents('tr:first').remove();} else {return false;}", id: id.to_s, class: 'fa fa-minus')
    #bs_a(confirm: '确认删除吗？', js: "$.get('#{url}', {format: 'js'});
    #      $('##{id.to_s}').parents('tr:first').nextAll('input[name=\"#{f.object_name}[id]\"]').remove();
    #      $('##{id.to_s}').parents('tr:first').remove();", id: id.to_s, icon: 'fa-minus')
  end

  def remove_line_tag(f, url)
    if f.object.new_record?
      js_remove_line_tag
    else
      remote_remove_line_tag(f, url)
    end
  end

  def email_tips_img(read)
    if read
      image_tag '/img/email_4_open.png'
    else
      image_tag '/img/email_4.png'
    end
  end

  def req(str)
    content_tag('span', :class => 'req-field') do
      raw(str)
    end
  end

  def panel_header(text='&nbsp;')
    content_tag('caption', nil, class: 'control-tr') do
      content_tag('div', nil, class: 'caption-bar') do
        content_tag('strong', text.html_safe)
      end
    end
  end

  #线性图
  def chart_line(data, x_axis, title, width, height=243, x_title='', y_title='')
    chart = LazyHighCharts::HighChart.new('line', :style => "height:#{height}px;width:#{width}px;") do |c|
      c.chart({:defaultSeriesType => "line", :margin => [5, 0, 40, 50], :renderTo => 'container'})

      #c.series(data)
      data.each { |y| c.series(:name => y["name"], :data => y["data"]) }
      c.options[:navigation]={:buttonOptions => {:align => 'right'}}
      c.options[:legend] = {:layout => 'horizontal', :align => 'center', :floating => true,
                            :verticalAlign => 'bottom', :x => 0, :y => 15}

      c.options[:xAxis]={:categories => x_axis, :title => {:text => x_title, :align => 'low'}}
      c.options[:yAxis]={:title => {:text => y_title}}
      c.options[:title]={:text => title}
      c.plotOptions(:line => {
          :allowPointSelect => true,
          :cursor => 'pointer',
          :dataLabels => {
              :color => '#000000',
              :percentageDecimals => 2,
              :enabled => true
          },
          :showInLegend => true
      })
    end

    chart

  end

  #柱状图
  def chart_bar(data, x_axis, title, width, height=243, x_title='', y_title='')
    chart = LazyHighCharts::HighChart.new('graph', :style => "height:#{height}px;width:#{width}px;") do |c|
      c.chart({:defaultSeriesType => "column", :margin => [5, 0, 60, 0], :renderTo => 'container'})

      #c.series(data)
      data.each { |y| c.series(:name => y["name"], :data => y["data"]) }
      c.options[:navigation]={:buttonOptions => {:align => 'right'}}
      #c.options[:legend] = {:layout => 'horizontal', :align => 'left', :floating => true,
      #                      :verticalAlign => 'top', :x => -15, :y => 0}

      c.options[:xAxis]={:categories => x_axis, :title => {:text => x_title, :align => 'high'}}
      c.options[:yAxis]={:title => {:text => y_title}}
      c.options[:title]={:text => title}
      c.plotOptions(:column => {
          :allowPointSelect => true,
          :cursor => 'pointer',
          :dataLabels => {
              :color => '#000000',
              :percentageDecimals => 2,
              :enabled => true
          },
          :showInLegend => true
      })
    end

    chart

  end

  #yAxis:hash数组from to color
  def speedometer(data, y_axis, y_title, title, width, min=0, max)
    chart = LazyHighCharts::HighChart.new('line', :style => "height:243px;width:#{width}px;") do |c|
      c.chart({type: 'gauge',
               plotBackgroundColor: nil,
               plotBackgroundImage: nil,
               plotBorderWidth: 0,
               plotShadow: false})

      c.series({
                   name: data[:name],
                   data: [format('%.2f', data[:data]).to_f],
                   tooltip: {
                       valueSuffix: data[:tooltip][:valueSuffix]
                   }
               })
      #c.series(data)

      c.options[:title] = {text: title}

      c.options[:pane]={startAngle: -150,
                        endAngle: 150,
                        background: [{
                                         backgroundColor: {
                                             linearGradient: {x1: 0, y1: 0, x2: 0, y2: 1},
                                             stops: [
                                                 [0, '#FFF'],
                                                 [1, '#333']
                                             ]
                                         },
                                         borderWidth: 0,
                                         outerRadius: '109%'
                                     }, {
                                         backgroundColor: {
                                             linearGradient: {x1: 0, y1: 0, x2: 0, y2: 1},
                                             stops: [
                                                 [0, '#333'],
                                                 [1, '#FFF']
                                             ]
                                         },
                                         borderWidth: 1,
                                         outerRadius: '107%'
                                     }, {
                                     }, {
                                         backgroundColor: '#DDD',
                                         borderWidth: 0,
                                         outerRadius: '105%',
                                         innerRadius: '103%'
                                     }]}

      c.options[:yAxis]={min: min,
                         max: max,

                         minorTickInterval: 'auto',
                         minorTickWidth: 1,
                         minorTickLength: 10,
                         minorTickPosition: 'inside',
                         minorTickColor: '#666',

                         tickPixelInterval: 30,
                         tickWidth: 2,
                         tickPosition: 'inside',
                         tickLength: 10,
                         tickColor: '#666',
                         labels: {
                             step: 2,
                             rotation: 'auto'
                         },
                         title: {
                             text: y_title
                         },
                         #plotBands: [{
                         #              from: 0,
                         #              to: 120,
                         #              color: '#22AC3C'
                         #             }, {
                         #                  from: 120,
                         #                  to: 160,
                         #                  color: '#DDDF0D'
                         #             }, {
                         #                  from: 160,
                         #                  to: 200,
                         #                  color: '#DF5353'
                         #             }]
                         plotBands: y_axis
      }

    end

    chart
  end

  #蜘蛛网
  def chart_spiderweb(data, x_axis, title, width)
    chart = LazyHighCharts::HighChart.new('line', :style => "height:200px;width:400px;") do |c|
      c.chart({:polar => true, :type => 'line', :margin => [0, 0, 0, 0], :renderTo => 'container'})

      c.series(data)

      c.options[:title] = {:text => title, :x => 0, :align => 'left'}

      c.options[:pane]={:size => '80%'}

      c.options[:xAxis]={
          categories: x_axis, #['Sales', 'Marketing', 'Development', 'Customer Support', 'Information Technology', 'Administration'],
          tickmarkPlacement: 'on',
          lineWidth: 0
      }
      c.options[:yAxis]={
          gridLineInterpolation: 'polygon',
          lineWidth: 0,
          min: 0,
          max: 1
      }

      c.options[:tooltip]= {
          #pointFormat: '<span style="color:{series.color}">{series.name}: <b>${point.y:,.0f}</b><br/>',
          shared: true
      }

      c.options[:legend] = {
          align: 'right',
          verticalAlign: 'top',
          y: 100,
          layout: 'vertical'
      }

    end
    chart

  end

end
