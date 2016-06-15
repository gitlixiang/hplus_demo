#coding: utf-8
class Pm::StatisticsController < ApplicationController
  def index
    @chart = LazyHighCharts::HighChart.new('graph', :style => "width:98%;") do |f|
      zero = Pm::Plan.all.select { |p| p.newest_percent == 0 || p.newest_percent.nil? }
      process = Pm::Plan.all.select { |p| p.newest_percent||0 < 100 && p.newest_percent||0 > 0 }
      finish = Pm::Plan.all.select { |p| p.newest_percent == 100 }

      f.title(:text => '今年项目进行情况分析')
      f.series({
                   type: 'pie',
                   name: '今年项目进行情况分析',
                   data: [
                       ['未开始', zero.size],
                       {
                           name: '正在进行',
                           y: process.size,
                           sliced: true,
                           selected: true
                       },
                       ['已完成', finish.size]
                   ]
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
end
