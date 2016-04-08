# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # limits the number of answers to 6 by hiding the add answer button when the limit is reached

  check_to_hide_or_show_add_link = ->
    if $('tbody#answer_table tr').length == 6
      $('.links').hide()
    else
      $('.links').show()
    return

  $('#answers').bind 'cocoon:after-insert', ->
    check_to_hide_or_show_add_link()
    return
  $('#answers').bind 'cocoon:after-remove', ->
    check_to_hide_or_show_add_link()
    return
  check_to_hide_or_show_add_link()
  return



	