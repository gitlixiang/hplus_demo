class Fdn::LegendCategory < ActiveRecord::Base

  acts_as_ordered_tree

  validates_uniqueness_of :position, scope: :parent_id

  scope :show, -> { where(status: 'Y') }
  scope :unshow, -> { where(status: 'N') }

  def parent_name
    return self.parent.blank? ? '' : self.parent.name
  end

  def show_list
    attr = ''
    self.ancestors.each do |c|
      attr += c.name+' \ '
    end
    attr += self.name
  end

  def self.build_list(c)
    i = 1
    items = []
    top_menus = Fdn::LegendCategory.where(depth: 0).order(:position)
    top_menus.each do |m|
      items << m.menu_html_str(true, c)
      i += 1
    end
    items.delete_if { |i| i.blank? }
  end

  def menu_html_str(top=false, cate)
    items = []
    children_menu = children.reject { |c| c.status != "Y" }
    children_menu.each do |c|
      str = c.menu_html_str(false, cate)
      items << str if !str.blank?
    end
    if !items.blank?
      item_str = "<ul class='nav nav-#{depth+2}-level collapse'>" + items.join + "</ul>"
    end
    #菜单链接全部使用onclick事件，取消href，目的是防止重复点击菜单时，后台数据一直在运行
    if top
      #判断是否有下级菜单
      if item_str.blank?
        return "<li class = '#{code==cate.code ? 'active' : ''}'><a href='#' id='#{code}'><i class='fa fa-gear'></i> #{name}</a></li>"
      else
        return "<li class = '#{code==cate.code ? 'active' : ''}'><a href='#' onclick='false' id='#{code}'><i class='fa fa-gear'></i> <span class='nav-label'>#{name}</span><span class='fa arrow'></span></a>#{item_str}</li>" #+ (is_last_top ? "" : "<li class='spacer'><span>|</span></li>")
      end
    else
      #判断是否有下级菜单
      if item_str.blank?
        return "<li class = '#{code==cate.code ? 'active' : ''}'><a href='#' id='#{code}'>#{name}</a></li>"
      else
        return "<li class = '#{code==cate.code ? 'active' : ''}' ><a href='#' onclick='false' id='#{code}'>#{name}<span class='fa arrow'></span></a>#{item_str}</li>"
      end
    end
  end
end
