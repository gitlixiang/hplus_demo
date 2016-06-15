#coding:utf-8
module Hr::EntTalentsHelper
  def ent_talent_header
    result = []
    result << {w: 2, t: '姓名'}
    result << {w: 1, t: '年龄'}
    result << {w: 1, t: '性别'}
    result << {w: 2, t: '工作时间'}
    result << {w: 4, t: '操作'}
    result
  end

  def search_ent_talent_header
    result = []
    result << {w: 2, t: '姓名'}
    result << {w: 3, t: '所属企业'}
    result << {w: 1, t: '年龄'}
    result << {w: 1, t: '性别'}
    result << {w: 2, t: '工作时间'}
    result << {w: 2, t: '操作'}
    result
  end

  def fdn_lookup_header
    result = []
    result << {w: 3, t: '类型名称'}
    result << {w: 3, t: '值的名称'}
    result << {w: 1, t: '编码'}
    result << {w: 1, t: '排序'}
    result << {w: 2, t: '操作'}
    result
  end
end
