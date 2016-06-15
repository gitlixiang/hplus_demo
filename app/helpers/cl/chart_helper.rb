module Cl::ChartHelper
  def handsontable_js_tag
    javascript_include_tag('handsontable/handsontable.full', 'handsontable/ruleJS.all.full', 'handsontable/handsontable.formula')
  end

  def handsontable_css_tag
    stylesheet_link_tag('handsontable/handsontable.full')
  end
end