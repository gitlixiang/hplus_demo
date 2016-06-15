#coding: utf-8
module Bootstrap3::EchartsHelper
  #name:     string     echats name   同一页面不要重复
  #op_name:  string     echats option 同一页面不要重复
  #obj_id:   string     显示的div的id 同一页面不要重复
  #legends:  arr        饼图的分类构成
  #obj_name: string     series的名称，自定义
  #data:     array      饼图的数据 [{value: 数值 , name: 名称（与legend对应）},{value:  , name: }...]
  #title:    string     饼图名称
  #radius:   true/false 饼图或者还行图  默认为false饼图
  def pie_echart(name, op_name, obj_id, legends, obj_name, data, title, sub_title='', radius=false)
    script = Array.new
    script << "var #{name} = echarts.init(document.getElementById('#{obj_id}'))"
    script << "var #{op_name} = {"
    script << "    title : {"
    script << "      text: '#{title}',"
    if !sub_title.blank?
      script << "      subtext: '#{sub_title}',"
    end
    script << "      x:'center'"
    script << "    },"
    script << "   toolbox: {"
    script << "       show: true,"
    script << "       feature: {"
    script << "           dataView : {show: true, readOnly: false},"
    script << "           restore: {show: true},"
    script << "           saveAsImage: {show: true}"
    script << "       }"
    script << "   },"
    script << "   tooltip: {"
    script << "   trigger: 'item',"
    script << "   formatter: '{a} <br/>{b}: {c} ({d}%)'"
    script << "},"
    script << "legend: {"
    script << "   orient: 'vertical',"
    script << "   x: 'left',"
    script << "   data:#{legends}"
    script << "},"
    script << " series: ["
    script << "    {"
    script << "      name:'#{obj_name}',"
    script << "      type:'pie',"
    if radius
      script << "      radius: ['50%', '70%'],"
    else
      script << "      radius: '50%',"
    end
    script << "      label: {"
    if radius
      script << "         normal: {"
      script << "            show: false,"
      script << "            position: 'center'"
      script << "         },"
    end
    script << "         emphasis: {"
    script << "            show: true,"
    script << "            textStyle: {"
    script << "                fontSize: '30',"
    script << "                fontWeight: 'bold'"
    script << "            }"
    script << "         }"
    script << "      },"
    script << "      labelLine: {"
    script << "           normal: {"
    script << "            show: false"
    script << "           }"
    script << "      },"
    script << "      data: #{data}"
    script << "    }"
    script << "    ]"
    script << "};"
    script << "#{name}.setOption(#{op_name});"
    script << "$(window).resize(#{name}.resize);"
    javascript_tag(script.join("\n"))
  end

  #name:     string     echats name   同一页面不要重复
  #op_name:  string     echats option 同一页面不要重复
  #obj_id:   string     显示的div的id 同一页面不要重复
  #legends:  arr        饼图的分类构成
  #data:     array      饼图的数据 [{value: 数值 , name: 名称（与legend对应）},{value:  , name: }...]
  #title:    string     饼图名称
  #obj_name: string     series的名称，自定义
  #echart_type:  line/bar
  #此方法同样适用于线图
  def echart(name, op_name, obj_id, legends, data, title, echart_type, obj_name)
    script = Array.new
    script << "var #{name} = echarts.init(document.getElementById('#{obj_id}'))"
    script << "var #{op_name} = {"
    script << "    title : {"
    script << "      text: '#{title}',"
    script << "      x:'center'"
    script << "    },"
    script << "    toolbox: {"
    script << "        show: true,"
    script << "        feature: {"
    script << "            dataZoom: {},"
    script << "            magicType: {type: ['line', 'bar']},"
    script << "            dataView : {show: true, readOnly: false},"
    script << "            restore: {show: true},"
    script << "            saveAsImage: {show: true}"
    script << "        }"
    script << "    },"
    script << "    tooltip: {"
    script << "        trigger: 'axis',"
    script << "        axisPointer : {"
    script << "            type : 'shadow'"
    script << "        }"
    script << "    },"
    script << "    legend: {"
    script << "       data: #{legends},"
    script << "       x: 'left'"
    script << "    },"
    script << "    xAxis: {"
    script << "       type: 'category',"
    script << "       data: #{legends}"
    script << "    },"
    script << "    yAxis: {"
    script << "       type: 'value'"
    script << "    },"
    script << "    series: ["
    script << "       {"
    script << "         name:'#{obj_name}',"
    script << "         type:'#{echart_type}',"
    script << "         label: {"
    script << "            normal: {"
    script << "               show: false,"
    script << "               position: 'inside'"
    script << "            },"
    script << "         },"
    script << "         labelLine: {"
    script << "              normal: {"
    script << "               show: false"
    script << "              }"
    script << "         },"
    script << "         data: #{data}"
    script << "       }"
    script << "    ]"
    script << "};"
    script << "#{name}.setOption(#{op_name});"
    script << "$(window).resize(#{name}.resize);"
    javascript_tag(script.join("\n"))
  end
end
