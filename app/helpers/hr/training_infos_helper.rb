#coding: utf-8
module Hr::TrainingInfosHelper
  def training_info_header
    result = []
    result << {w: 3, t: '课程名称'}
    result << {w: 2, t: '讲课时间'}
    result << {w: 2, t: '主讲人'}
    result << {w: 2, t: '负责人'}
    result << {w: 2, t: '操作'}
    result
  end
end