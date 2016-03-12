# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'change', '#categories_select', (evt) ->
    $.ajax '../../questions/update_questions',
      type: 'GET'
      dataType: 'script'
      data: {"category_id": $("#categories_select option:selected").val()}
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic question select OK!")

$('#questions a.add_fields').data('association-insertion-position', 'before').data 'association-insertion-node', 'this'
$('#questions').on 'cocoon:after-insert', ->
  $('.link-fields a.add_fields').data('association-insertion-position', 'before').data 'association-insertion-node', 'this'
  $('.link-fields').on 'cocoon:after-insert', ->
    $(this).children('#question_from_list').remove()
    $(this).children('a.add_fields').hide()
    return
  return


