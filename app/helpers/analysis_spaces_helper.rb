#coding: utf-8
module AnalysisSpacesHelper
  def chart_include_tag
    javascript_include_tag('lazy_high_charts/highcharts', 'lazy_high_charts/exporting')
  end

  #一个自定义的月份数组[12,1,2]
  def months_array(from, length=12)
    arr = []
    length.times do |i|
      month = (from+i)
      arr << (month%12==0 ? 12 : (month%12))
    end
    arr
  end

  #返回现在起到之前的年月数组·［...[2013,11],[2013,12],[2014,1]］
  def years_months_array(year, month, length=12)
    #time = Time.mktime(year,month)
    #length.times do |i|
    #  arr << [(time-i.months).year,(time-i.months).month]
    #end
    #arr.reverse!
    year = year.to_i if year.is_a?(String)
    month = month.to_i if month.is_a?(String)
    arr = []
    if month == 12
      (1..12).each { |x| arr << [year, x] }
    else
      length.times do |i|
        if month+i+1 <= 12
          arr << [year-1, month+i+1]
        else
          m = month+i+1
          arr << [year, m==12 ? 12 : m%12]
        end
      end

    end
    arr
  end


  ##饼图
  #def chart_pie(arr, name, title, width)
  #  chart = LazyHighCharts::HighChart.new('pie', :style => "height:243px;width:#{width}px;") do |c|
  #    c.chart({:defaultSeriesType => "pie", :margin => [0, 0, 0, 0], :plotBorderWidth => nil, :plotShadow => false})
  #    series = {
  #        :type => 'pie',
  #        :name => name,
  #        :data => arr
  #    }
  #    c.series(series)
  #    c.options[:title]={:text=>title}
  #    c.navigation({:buttonOptions=> {:align=>'right'}})
  #    c.plotOptions(:pie => {
  #        :allowPointSelect => true,
  #        :cursor => 'pointer',
  #        :size => '70%',
  #        :dataLabels => {
  #            :color => '#000000',
  #            :distance => 1,
  #            :connectorPadding => 0,
  #            :connectorWidth => 1,
  #            :softConnector => false,
  #            :enabled => true
  #        },
  #        :showInLegend => false
  #    })
  #    c.options[:legend] = {:layout => 'horizontal', :align => 'right', :width => 140, :floating => true}
  #  end
  #  chart
  #
  #end
  #
  ##线性图
  ##name 为x轴数组
  #def chart_line(data, x_axis, title, width, height=243, x_title='', y_title='')
  #  chart = LazyHighCharts::HighChart.new('line', :style => "height:#{height}px;width:#{width}px;") do |c|
  #    c.chart({:defaultSeriesType => "line", :margin => [5, 0, 40, 50], :renderTo => 'container'})
  #
  #    #c.series(data)
  #    data.each {|y|c.series(:name => y["name"], :data => y["data"])}
  #    c.options[:navigation]={:buttonOptions=> {:align=>'right'}}
  #    c.options[:legend] = {:layout => 'horizontal', :align => 'center', :floating => true,
  #                          :verticalAlign => 'bottom', :x => 0, :y => 15}
  #
  #    c.options[:xAxis]={:categories => x_axis, :title => {:text => x_title, :align => 'low'}}
  #    c.options[:yAxis]={:title => {:text=> y_title}}
  #    c.options[:title]={:text=>title}
  #    c.plotOptions(:line => {
  #        :allowPointSelect => true,
  #        :cursor => 'pointer',
  #        :dataLabels => {
  #            :color => '#000000',
  #            :percentageDecimals => 2,
  #            :enabled => true
  #        },
  #        :showInLegend => true
  #    })
  #  end
  #
  #  chart
  #
  #end
  #
  ##柱状图
  #def chart_bar(x_axis, y_axis, title, width, y_title= nil)
  #  #x轴文字15px，legend25px
  #  chart = LazyHighCharts::HighChart.new('graph', :style => "height:243px;width:#{width}px;") do |c|
  #    c.chart({:defaultSeriesType => "column", :margin => [5, 0, 40, 20], :renderTo => 'container'})
  #    c.series()
  #    y_axis.each {|y| c.series(:name => y["name"], :data => y["data"])}
  #    c.options[:title][:text] = title
  #    c.options[:xAxis]={:categories => x_axis}
  #    c.options[:yAxis]={:stackLabels => {
  #        :enabled => true,
  #        :style => {
  #            :fontWeight => 'bold',
  #            :color => 'gray'
  #        }
  #        },
  #        :title=> {:text=> y_title}
  #    }
  #    c.options[:navigation]={:buttonOptions=> {:align=>'right'}}
  #
  #    c.options[:legend] = {:layout => 'horizontal', :align => 'center', :floating => true,
  #                          :verticalAlign => 'bottom', :x => 0, :y => 15}
  #    c.plotOptions(:column => {
  #        :dataLabels => {
  #            :color => 'gray',
  #            :enabled => true,
  #            :pointPadding => 0.2,
  #            :percentageDecimals => 2,
  #            :borderWidth => 0
  #        },
  #        :showInLegend => true
  #    })
  #  end
  #  chart
  #end
  #
  ##蜘蛛网
  #def chart_spiderweb(data, x_axis, title, width)
  #  chart = LazyHighCharts::HighChart.new('line', :style => "height:200px;width:400px;") do |c|
  #    c.chart({:polar => true, :type => 'line', :margin => [0, 0, 0, 0], :renderTo => 'container'})
  #
  #    c.series(data)
  #
  #    c.options[:title] = {:text=>title, :x => 0, :align => 'left'}
  #
  #    c.options[:pane]={:size=> '80%'}
  #
  #    c.options[:xAxis]={
  #        categories: x_axis, #['Sales', 'Marketing', 'Development', 'Customer Support', 'Information Technology', 'Administration'],
  #        tickmarkPlacement: 'on',
  #        lineWidth: 0
  #    }
  #    c.options[:yAxis]={
  #        gridLineInterpolation: 'polygon',
  #        lineWidth: 0,
  #        min: 0,
  #        max:1
  #    }
  #
  #    c.options[:tooltip]= {
  #        #pointFormat: '<span style="color:{series.color}">{series.name}: <b>${point.y:,.0f}</b><br/>',
  #        shared: true
  #    }
  #
  #    c.options[:legend] = {
  #        align: 'right',
  #        verticalAlign: 'top',
  #        y: 100,
  #        layout: 'vertical'
  #    }
  #
  #  end
  #  chart
  #
  #end
  #
  ##yAxis:hash数组from to color
  #def speedometer(data, y_axis, y_title, title, width, max)
  #  chart = LazyHighCharts::HighChart.new('line', :style => "height:243px;width:#{width}px;") do |c|
  #    c.chart({type: 'gauge',
  #             plotBackgroundColor: nil,
  #             plotBackgroundImage: nil,
  #             plotBorderWidth: 0,
  #             plotShadow: false})
  #
  #    c.series({
  #                 name: data[:name],
  #                 data: [format('%.2f',data[:data]).to_f],
  #                 tooltip: {
  #                     valueSuffix: data[:tooltip][:valueSuffix]
  #                 }
  #             })
  #    #c.series(data)
  #
  #    c.options[:title] = {text: title}
  #
  #    c.options[:pane]={startAngle: -150,
  #                      endAngle: 150,
  #                      background: [{
  #                                       backgroundColor: {
  #                                           linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
  #                                           stops: [
  #                                                               [0, '#FFF'],
  #                                                               [1, '#333']
  #                                                           ]
  #                                       },
  #                                       borderWidth: 0,
  #                                       outerRadius: '109%'
  #                                   }, {
  #                                       backgroundColor: {
  #                                           linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
  #                                           stops: [
  #                                                               [0, '#333'],
  #                                                               [1, '#FFF']
  #                                                           ]
  #                                       },
  #                                       borderWidth: 1,
  #                                       outerRadius: '107%'
  #                                   }, {
  #    }, {
  #        backgroundColor: '#DDD',
  #        borderWidth: 0,
  #        outerRadius: '105%',
  #        innerRadius: '103%'
  #    }]}
  #
  #    c.options[:yAxis]={min: 0,
  #                       max: max+max/10,
  #
  #                       minorTickInterval: 'auto',
  #                       minorTickWidth: 1,
  #                       minorTickLength: 10,
  #                       minorTickPosition: 'inside',
  #                       minorTickColor: '#666',
  #
  #                       tickPixelInterval: 30,
  #                       tickWidth: 2,
  #                       tickPosition: 'inside',
  #                       tickLength: 10,
  #                       tickColor: '#666',
  #                       labels: {
  #                           step: 2,
  #                           rotation: 'auto'
  #                       },
  #                       title: {
  #                           text: y_title
  #                       },
  #                       #plotBands: [{
  #                       #              from: 0,
  #                       #              to: 120,
  #                       #              color: '#55BF3B'
  #                       #             }, {
  #                       #                  from: 120,
  #                       #                  to: 160,
  #                       #                  color: '#DDDF0D'
  #                       #             }, {
  #                       #                  from: 160,
  #                       #                  to: 200,
  #                       #                  color: '#DF5353'
  #                       #             }]
  #                        plotBands: y_axis
  #    }
  #
  #  end
  #
  #  chart
  #end


  private
  #def default_opt(c, title, x_axis)
  #  c.options[:title][:text] = title
  #  c.options[:xAxis]={:categories => x_axis}
  #  c.options[:legend] = {:layout => 'horizontal'}
  #end

end
