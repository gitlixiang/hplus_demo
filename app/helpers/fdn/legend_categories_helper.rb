#coding: utf-8
module Fdn::LegendCategoriesHelper
  def category_index_links(category)
    [{value: '查看', url: fdn_legend_category_path(category)},
     {value: '编辑', url: edit_fdn_legend_category_path(category)},
     {value: (category.status == "N" ? "启用" : "停用"),
      url: stop_fdn_legend_categories_path, params: "'id' : '#{category.id}', 'act': '#{category.status == 'N' ? 'Y' : 'N'}'",
      confirm: "确定#{(category.status == "N" ? "启用" : "停用")}吗？", url_method: 'confirm', tips: "信息分类已#{(category.status == "N" ? "启用" : "停用")}！"}]
  end
end
