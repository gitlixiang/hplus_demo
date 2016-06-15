module Wf::JavaMethodHelper
  def format_java_date(time)
    (time.getYear+ 1900).to_s+'-'+time.getMonth.to_s+'-'+time.getDay.to_s if time
  end

  def format_java_time(time)
    #(time.getYear+ 1900).to_s+'-'+time.getMonth.to_s+'-'+time.getDay.to_s+' '+time.getHour+':'+time.getMinute+':'+time.getSecond  if time
  end
end
