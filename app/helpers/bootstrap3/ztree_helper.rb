#coding: utf-8
module Bootstrap3::ZtreeHelper

  def ztree_include_tag
    output = javascript_include_tag('/js/plugins/ztree/jquery.ztree.core.js')
    #output << javascript_include_tag('/js/plugins/ztree/jquery-1.4.4.min.js')
    output << stylesheet_link_tag('/css/plugins/ztree/ztree.css')
    output << stylesheet_link_tag('/css/plugins/ztree/demo.css')
  end

  #text_id： input输入框id
  #obj_id： tree的id
  #search_id: 查询框的id
  #node： tree的json数据{id: .. , pId: .. , name: ..}

  def ztree_default_demo(text_id, obj_id, search_id, node)
    content = content_tag('input', nil, class: "form-control", id: text_id, onclick: "showMenu();return false;", readonly: true)
    content << content_tag('div', nil, class: 'menuContent', id: 'menuContent', style: "display:none;") do
      result = ''
      result << content_tag('input', nil, class: "form-control", id: search_id)
      result << content_tag('ul', nil, class: "ztree", id: 'treeDemo')
      raw result
    end
    content << ztree_org_tag(text_id, obj_id, search_id, node)
    raw content
  end

  def ztree_org_tag(text_id, obj_id, search_id, node)
    script = Array.new
    script << "   var setting = {"
    script << "			view: {"
    script << "				dblClickExpand: false"
    script << "			},"
    script << "			data: {"
    script << "				simpleData: {"
    script << "					enable: true"
    script << "				}"
    script << "			},"
    script << "			callback: {"
    script << "				beforeClick: beforeClick,"
    script << "				onClick: onClick"
    script << "			}"
    script << "		};"
    script << "		var zNodes = #{node};"
    script << "		function beforeClick(treeId, treeNode) {"
    script << "			var check = (treeNode && !treeNode.isParent);"
    script << "			if (!check) alert('只能选择子节点...');"
    script << "			return check;"
    script << "		}"
    script << "		function onClick(e, treeId, treeNode) {"
    script << "			var zTree = $.fn.zTree.getZTreeObj('treeDemo'),"
    script << "			nodes = zTree.getSelectedNodes(),"
    script << "			v = '';"
    script << "			v_id = '';"
    script << "			nodes.sort(function compare(a,b){return a.id-b.id;});"
    script << "			for (var i=0, l=nodes.length; i<l; i++) {"
    script << "				v += nodes[i].name + ',';"
    script << "				v_id += nodes[i].id + ',';"
    script << "			}"
    script << "			if (v.length > 0 ) v = v.substring(0, v.length-1);"
    script << "			var cityObj = $('##{text_id}');"
    script << "			cityObj.attr('value', v);"
    script << "			if (v_id.length > 0 ) v_id = v_id.substring(0, v_id.length-1);"
    script << "			var idObj = $('##{obj_id}');"
    script << "			idObj.attr('value', v_id);"
    script << "		}"
    script << "		function showMenu() {"
    script << "			var cityObj = $('##{text_id}');"
    script << "			var cityOffset = $('##{text_id}').offset();"
    script << "			$('#menuContent').css({left:cityOffset.left + 'px', top:cityOffset.top + cityObj.outerHeight() + 'px'}).slideDown('fast');"
    script << "			$('body').bind('mousedown', onBodyDown);"
    script << "			$('##{search_id}').val('');"
    script << "		}"
    script << "		function hideMenu() {"
    script << "			$('#menuContent').fadeOut('fast');"
    script << "			$('body').unbind('mousedown', onBodyDown);"
    script << "		}"
    script << "		function onBodyDown(event) {"
    script << "			if (!(event.target.id == 'menuBtn' || event.target.id == 'menuContent' || $(event.target).parents('#menuContent').length>0)) {"
    script << "				hideMenu();"
    script << "			}"
    script << "		}"
    script << "		$(document).ready(function(){"
    script << "			$.fn.zTree.init($('#treeDemo'), setting, zNodes);"
    script << "		});"
    script << "		setInterval("
    script << "		  function check_value() {"
    script << "		    var search_value = $('##{search_id}').val()"
    script << "		    $('#treeDemo').find('a.org').each(function () {"
    script << "		      if (search_value == '' || search_value == null) {"
    script << "		        $(this).parent().css('display', 'inherit');"
    script << "		        $(this).children('.node_name').css('color','');"
    script << "		      } else if($(this).attr('title').indexOf(search_value)< 0) {"
    script << "		        $(this).parent().css('display','none');"
    script << "		        $(this).children('.node_name').css('color','');"
    script << "		      } else {"
    script << "		        $(this).parent().css('display', 'inherit');"
    script << "		        $(this).children('.node_name').css('color','red');"
    script << "		        $(this).parent().parents('li').each(function () {"
    script << "		        $(this).css('display', 'inherit');"
    script << "		      })"
    script << "		    }"
    script << "		  });"
    script << "		},1000)"
    javascript_tag(script.join("\n"))
  end

end