# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('body').delegate "a[data-js], button[data-js], input[data-js]", 'click', (e) ->
    e.preventDefault()
    message = $(this).data('confirm-message')
    action = $(this).data('js')
    if message
      $.showConfirm action, message
    else
      eval(action)

  #处理所有提交页面按钮
  #如果使用data-confirm-message，只支持一个页面一个form
  $('form').delegate "button[type=\"submit\"], input[type=\"submit\"]", 'click', (e) ->
    form = $(this).parents('form')
    form.validate();
    if form.valid()
      $(this).attr('disabled', 'disabled')
      e.preventDefault()
      action = "$('form').get(0).submit()"
      message = $(this).data('confirm-message')
      if message
        $.showConfirm action, message
      else
        $(this).parents('form').get(0).submit()
    else
      return false

  #防止多次点击菜单 后台不停的读取刷新
  $('#side-menu').delegate "a", 'click', (e) ->
    $(this).attr('onclick', 'return false;')