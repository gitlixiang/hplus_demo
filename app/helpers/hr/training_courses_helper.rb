#coding: utf-8
module Hr::TrainingCoursesHelper
  def training_course_header
    result = []
    result << {w: 3, t: '培训班名称'}
    result << {w: 2, t: '成立时间'}
    result << {w: 4, t: '培训方向'}
    result << {w: 2, t: '操作'}
    result
  end
end
