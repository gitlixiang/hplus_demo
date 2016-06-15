#coding: utf-8
module Bootstrap3::ComponentHelper
  extend ActiveSupport::Concern

  #link 按钮跳转页面
  def bs_button_link_to(link, action_desc='', css='', icon='')
    css = (css.blank? ? 'btn-primary btn-sm' : css)
    content_tag('button', nil, class: "btn #{css}", title: "#{action_desc}", type: 'button', onclick: !link.blank? ? "window.location='#{link}';" : '') do
      content = ''
      unless icon == ''
        content << content_tag('i', nil, class: icon)
      end
      content << "&nbsp;#{action_desc}".html_safe
      raw content
    end
  end

  #执行js命令
  def bs_button_js_to(link, action_desc='', css='', icon='')
    css = (css.blank? ? 'btn-primary btn-sm' : css)
    content_tag('button', nil, class: "btn #{css}", title: "#{action_desc}", type: 'button', onclick: !link.blank? ? "#{link};" : '') do
      content = ''
      unless icon == ''
        content << content_tag('i', nil, class: icon)
      end
      content << "&nbsp;#{action_desc}".html_safe
      raw content
    end
  end

  #纯按钮
  def bs_button(id='btn', action_desc='', css='', icon='')
    css = (css.blank? ? 'btn-primary btn-sm' : css)
    content_tag('button', nil, class: "btn #{css}", title: "#{action_desc}", type: 'button', id: id, name: id) do
      content = ''
      unless icon == ''
        content << content_tag('i', nil, class: icon)
      end
      content << "&nbsp;#{action_desc}".html_safe
      raw content
    end
  end

  #link a链接跳转页面
  def bs_link_to(link, action_desc='', css='', icon='')
    css = (css.blank? ? '' : css)
    content_tag('a', nil, class: "", title: "#{action_desc}", onclick: "window.location='#{link}';") do
      content = ''
      unless icon == ''
        content << content_tag('i', nil, class: icon)
      end
      content << "&nbsp;#{action_desc}".html_safe
      raw content
    end
  end

  #按钮：打开新窗口
  def bs_button_window(link, action_desc='', css='', icon='', width='800px', height='440px')
    css = (css.blank? ? 'btn-primary btn-sm' : css)
    content_tag('button', nil, class: "btn #{css}", title: "#{action_desc}", type: 'button', onclick: open_window_js(action_desc, link, width, height)) do
      content = ''
      unless icon == ''
        content << content_tag('i', nil, class: icon)
      end
      content << "&nbsp;#{action_desc}".html_safe
      raw content
    end
  end

  #a标签：打开新窗口
  def bs_link_window(link, action_desc='', css='', icon='', title='')
    css = (css.blank? ? '' : css)
    content_tag('a', nil, class: "", title: "#{title}", onclick: open_window_js(title, link, '800px', '440px')) do
      content = ''
      unless icon == ''
        content << content_tag('i', nil, class: icon)
      end
      content << "#{action_desc}".html_safe
      raw content
    end
  end

  #confirm：打开confirm窗口执行js
  def bs_confirm_window(link, action_desc='', params='', icon='', confirm, tips)
    content_tag('a', nil, class: "", title: "#{action_desc}", onclick: open_confirm_window_js(link, params, confirm, tips)) do
      content = ''
      unless icon == ''
        content << content_tag('i', nil, class: icon)
      end
      content << "#{action_desc}".html_safe
      raw content
    end
  end

  #保存按钮
  def bs_save(css='')
    css = (css.blank? ? 'btn-primary btn-sm' : css)
    content_tag('button', nil, class: "btn #{css}", title: "保存", type: "submit") do
      content = ''
      content << content_tag('i', nil, class: 'fa fa-check-square-o')
      content << "&nbsp;保存".html_safe
      raw content
    end
  end

  #下一步/完成
  def bs_save_tag(label, id='tag')
    css = (css.blank? ? 'btn-primary btn-sm' : css)
    output = content_tag('button', nil, class: "btn #{css}", title: label, type: "submit", name: id, id: id) do
      content = ''
      content << content_tag('i', nil, class: 'fa fa-arrow-right')
      content << "&nbsp;"+label.html_safe
      raw content
    end
    output << hidden_field_tag(id, '', disabled: 'disabled')
    output << javascript_tag do
      raw <<JSCRIPT
      $('button##{sanitize_to_id(id)}').click(function(e) {
        $('input##{sanitize_to_id(id)}').removeAttr('disabled');
      });
JSCRIPT
    end
  end

  #下一步/完成
  def bs_next(value='提交下一岗', css=nil)
    css = (css.blank? ? 'btn-primary btn-sm' : css)
    output = content_tag('button', nil, class: "btn #{css}", title: value, type: "submit", name: 'bs_next', id: 'bs_next') do
      content = ''
      content << content_tag('i', nil, class: 'fa fa-arrow-right')
      content << "&nbsp;"+value.html_safe
      raw content
    end
    output << hidden_field_tag('bs_next', '', disabled: 'disabled')
    output << javascript_tag do
      raw <<JSCRIPT
      $('button##{sanitize_to_id('bs_next')}').click(function(e) {
        $('input##{sanitize_to_id('bs_next')}').removeAttr('disabled');
      });
JSCRIPT
    end
  end

  #上一步
  def bs_prev(value='退回上一岗', css=nil)
    css = (css.blank? ? 'btn-primary btn-sm' : css)
    output = content_tag('button', nil, class: "btn #{css}", title: value, type: "submit", name: 'bs_prev', id: 'bs_prev') do
      content = ''
      content << content_tag('i', nil, class: 'fa fa-arrow-left')
      content << "&nbsp;"+value.html_safe
      raw content
    end
    output << hidden_field_tag('bs_prev', '', disabled: 'disabled')
    output << javascript_tag do
      raw <<JSCRIPT
      $('button##{sanitize_to_id('bs_prev')}').click(function(e) {
        $('input##{sanitize_to_id('bs_prev')}').removeAttr('disabled');
      });
JSCRIPT
    end
  end


  #关闭按钮
  def bs_close(css='')
    css = (css.blank? ? 'btn btn-warning btn-sm' : css)
    bs_button_js('parent.layer.close(parent.MAIN_LAYER_WINDOW);', '关闭', css, 'fa fa-times')
  end

  #按钮栏
  def button_div(position='top', &block)
    result = ''
    if position == 'bottom'
      result << content_tag('div', nil, class: 'hr-line-dashed')
    end
    #z-index: 90;position: fixed;background: #f3f3f4;height: 40px;width: 100%;  置顶样式  需要改进
    result << content_tag('div', nil, class: 'row') do
      content_tag('div', nil, class: 'col-sm-offset-6 col-sm-6 text-right') do
        capture(&block) if block
      end
    end
    raw result
  end

  #创建
  def bs_add(link)
    bs_button_link_to(link, '创建', '', 'fa fa-plus')
  end

  #查询
  #def bs_search(link)
  #  bs_button_link_to(link, '查询', '', 'fa fa-search')
  #end
  def bs_search(css='')
    css = css + ' btn-primary btn-sm'
    content_tag('button', nil, class: "btn #{css}", type: "submit", title: '查询') do
      content = ''
      content << content_tag('i', nil, class: 'fa fa-search')
      raw content
    end
  end

  #重置
  def bs_clear(link, css='')
    css = css + ' btn-primary btn-sm'
    content_tag('button', nil, class: "btn #{css}", type: 'button', title: "重置", onclick: !link.blank? ? "window.location='#{link}';" : '') do
      content = ''
      content << content_tag('i', nil, class: 'fa fa-repeat')
      raw content
    end
  end

  #返回
  def bs_return(link)
    bs_button_link_to(link, '返回', 'btn btn-warning btn-sm', 'fa fa-undo')
  end

  #导出
  def bs_export(link, css='')
    css = css + ' btn-primary btn-sm'
    content_tag('button', nil, class: "btn #{css}", type: 'button', title: "导出", onclick: !link.blank? ? "window.location='#{link}';" : '') do
      content = ''
      content << content_tag('li', nil, class: 'fa fa-file-excel-o')
      #content << "&nbsp;导出".html_safe
      raw content
    end
  end

  #导入
  def bs_import(link)
    bs_button_link_to(link, '导入', '', 'fa fa-file-excel-o')
  end

  #预览
  def bs_preview(link)
    bs_button_link_to(link, '预览', '', 'fa fa-eye')
  end

  #统计
  def bs_stat(link)
    bs_button_link_to(link, '统计', '', 'fa fa-table')
  end

  #打印
  def bs_print(link)
    bs_button_link_to(link, '打印', '', 'fa fa-print')
  end

  def bs_button_js(js, action_desc='', css='', icon='')
    css = (css.blank? ? 'btn-primary btn-sm' : css)
    content_tag('button', nil, class: "btn #{css}", onclick: js) do
      content = ''
      unless icon == ''
        content << content_tag('i', nil, class: icon)
      end
      content << "&nbsp;#{action_desc}".html_safe
      raw content
    end
  end

  #根据controller中的actions方法生成对应按钮组
  def bs_ibox_tools(div_id, controller_path, id)
    #组装controller_name名称
    c_class_name = controller_path.titleize.sub('/', '::') + 'Controller'
    #生成controllerClass
    c_class = c_class_name.classify.constantize
    #取得controller所有actions方法
    c_actions = c_class.action_methods

    content = ''
    if c_actions.include?('copy')
      content << content_tag('a') do
        content_tag('i', nil, class: 'fa fa-copy', title: '复制', id: "toolbox_copy_#{div_id}")
      end
    end
    if c_actions.include?('edit')
      content << content_tag('a', nil) do
        content_tag('i', nil, class: 'fa fa-edit', title: '编辑', id: "toolbox_edit_#{div_id}", onclick: open_window_js('编辑', url_for(:controller => controller_path, :action => :edit, :id => id), '800px', '440px'))
      end
    end
    if c_actions.include?('destroy')
      content << content_tag('a', nil, 'data-confirm' => "确认删除此条数据吗?", 'data-method' => "delete", rel: "nofollow", href: url_for(:controller => controller_path, :action => :destroy, :id => id)) do
        content_tag('i', nil, class: 'fa fa-trash', title: '删除', id: "toolbox_destroy_#{div_id}")
      end
    end
    if c_actions.include?('print')
      content << content_tag('a') do
        content_tag('i', nil, class: 'fa fa-print', title: '打印', id: "toolbox_print_#{div_id}")
      end
    end

    content_tag('div', content.html_safe, class: 'ibox-tools', id: "toolbox_#{div_id}")
  end

  protected
  def render_div(opts={}, &block)
    content_tag('div', nil, opts) do
      capture(&block) if block
    end
  end

  # Nav : tabs, pills, and lists
  # bootstrap navs
  # 操作链接条，可选是否显示为导航按钮，不完全实现，基本可用
  # nav: true, false
  # type: pills, tabs 都可以， tab 有专门helper实现，   list支持不好
  # direction: h, v h:水平, v:垂直
  # links: Array 每一个元素是一个hash， hash中的元素参考 bootstrap_link_helper/bs_a
  def action_links(links, nav=false, type='pills', direction='h', nav_margin=0)
    if nav
      content_tag('ul', nil, class: "nav nav-#{type} #{direction == 'v' ? 'nav-stacked' : ''} #{nav_margin == 0 ? 'm0a' : ''}") do
        links(links)
      end
    else
      content_tag('span', nil, class: "action-links m0a") do
        links(links, "|")
      end
    end
  end

  #暂时先用下面的nav_bar方法，本方法是老样式
  # Navbar
  # 显示navbar， 实现功能不多， 暂时够用
  # fix: top 悬浮在顶端， bottom 悬浮在底端， 其他，不悬浮
  # align: l, r 内容靠左或靠右，默认靠右
  # &block ，navbar的内容
  def navbar(fix=false, position=nil, align='r', &block)

    result = ''
    case fix
      when 'top'
        fixclass = 'navbar-fixed-top navbar-always-fixed'
        result << javascript_tag do
          raw <<JSS
              $(document).ready(function(){ if ($('.navbar-fixed-top').css('position') != 'static') $('body').css('padding-top','40px');});
JSS
        end
      when 'bottom'
        fixclass = 'navbar-fixed-bottom navbar-always-fixed'
        result << javascript_tag do
          raw <<JSS
              $(document).ready(function(){ if ($('.navbar-fixed-top').css('position') != 'static') $('body').css('padding-bottom','40px');});
JSS
        end
      else
        fixclass = ''
    end


    result << content_tag('div', nil, class: 'navbar ' + fixclass) do
      content_tag('div', nil, class: 'navbar-inner') do
        content = ''
        unless position.blank?
          content << content_tag('div', nil, class: 'text-info span5 navbar-current-position') do
            content_tag('small', "当前位置： #{position}")
          end
        end

        content << content_tag('div', nil, class: "#{align == 'r' ? 'pull-right' : ''}") do
          capture(&block) if block
        end
        raw content
      end
    end

    raw result
  end


  # Navbar
  # 显示navbar， 实现功能不多， 暂时够用
  # menu: 菜单对象
  # &block ，navbar的内容
  #暂时先用这个，这个是新样式
  def nav_bar(menu, &block)
    result = ''

    result << content_tag('div', nil, class: 'row wrapper border-bottom white-bg') do
      result2 = ''
      result2 << content_tag('div', nil, class: 'col-sm-6') do
        content_tag('ol', nil, class: "breadcrumb") do
          content2 = ''
          content2 << content_tag('li', '主页'.html_safe, nil)
          menu.ancestors.reject { |me| me.code == 'root' }.each do |parent|
            content2 << content_tag('li', content_tag('a', "#{parent.name}").html_safe, nil)
          end
          content2 << content_tag('li', content_tag('strong', "#{menu.name}").html_safe, nil)
          raw content2
        end
      end
      if block
        result2 << content_tag('div', nil, class: "col-sm-6 text-right") do
          capture(&block)
        end
      end
      raw result2
    end

    raw result
  end


  # Alerts Styles for success, warning, and error messages
  # title 标题
  # contents 数组，每行一个元素
  # options: {type: 'error' , .....} 默认 error
  def alert(title, contents=[], options={})
    type = options.delete(:type) || 'error'
    actual_class = "alert alert-#{type} #{options.delete(:class)}"
    content_tag('div', nil, {class: actual_class}.merge(options)) do
      alert_content = button_tag(raw('&times;'), :type => 'button', :class => 'close', 'data-dismiss' => 'alert')
      alert_content << content_tag('h4', title)
      alert_content << content_tag('p')
      alert_content << content_tag('ul') do
        ul_content = ''
        contents.each do |content|
          ul_content << content_tag('li', content, class: "text-#{type}")
        end
        ul_content.html_safe
      end
      alert_content.html_safe
    end
  end


end