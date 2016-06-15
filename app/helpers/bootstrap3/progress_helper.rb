#coding: utf-8
module Bootstrap3::ProgressHelper
  #success warning danger default
  def progress_bar(num, color = 'default')
    content_tag('div', nil, class: 'progress progress-striped active', style: 'margin-bottom: 0px') do
      content_tag('div', nil, style: "width: #{num}%", 'aria-valuemax' => '100', 'aria-valuemin' => '0', 'aria-valuenow' => "#{num}", 'role' => 'progressbar', 'class' => "progress-bar progress-bar-#{color}") do
        "#{num}%" #content_tag('span', "#{num}% Complete (#{color})", class: 'sr-only')
      end
    end
  end

  def state_bar(num)
    case num
      when 0
        "<span class='label label-primary'>未开始".html_safe
      when 1..99
        "<span class='label label-info'>进行中".html_safe
      when 100
        "<span class='label label-success'>已完成".html_safe
      else
        "<span class='label label-warning'>无数据".html_safe
    end
  end
end