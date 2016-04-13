# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  #When the value of category select is changed then send the category id and the id of the select box to the 
  #update_questions method so that the questions select can be updated. If this is successfull then also update
  #the displayed answers by sending the new value in the questions select to the update answers
  $(document).on 'change', '[id^=categories_select]', (evt) ->
    $.ajax '../../questions/update_questions',
      type: 'GET'
      dataType: 'script'
      data: {"ajax_category_id": $("#categories_select" + evt.target.id.slice(17) + " option:selected").val(), "question_no": evt.target.id.slice(17)}
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic question select OK! a")
        $.ajax '../../answers/update_answers',
          type: 'GET'
          dataType: 'script'
          data: {"ajax_question_id": $("#questions_select" + evt.target.id.slice(17) + " option:selected").val(), "question_no" : evt.target.id.slice(17)}
          error: (jqXHR, textStatus, errorThrown) ->
            console.log("AJAX Error: #{textStatus}")
          success: (data, textStatus, jqXHR) ->
            console.log("Dynamic question select OK! c")

  #update the answers when the question drop down is selected
  $(document).on 'change', '[id^=questions_select]', (evt) ->
    $.ajax '../../answers/update_answers',
      type: 'GET'
      dataType: 'script'
      data: {"ajax_question_id": $("#questions_select" + evt.target.id.slice(16) + " option:selected").val(), "question_no" : evt.target.id.slice(16)}
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic question select OK! b")


#called when link_to_add_association is pressed. gets the category question and answer bits and gives them an id that will
#be a random number. This is so that dependent drop downs can work independently
$(document).ready ->
  $('tbody#question_table a.add_fields').data('association-insertion-position', 'before').data 'association-insertion-node', 'this'
  $('tbody#question_table').on 'cocoon:after-insert', ->
      randno = Math.floor Math.random() * 99999999 + 1
      $(this).children('.table_row').children('.col-sm-1').children('.field').children('#categories_select_1').attr 'id', 'categories_select_' + randno
      $(this).children('.table_row').children('.col-sm-3').children('.field').children('#questions_select_1').attr 'id', 'questions_select_' + randno
      $(this).children('.table_row').children('.col-sm-6').children('#displayed_answers').attr 'id', 'displayed_answers_' + randno
      return

#listens for change of language drop down and changes direction of fields accordingly
  $(document).on 'change', '#quiz_language_id', (evt) ->
    $.ajax '/quizzes/update_quizzes_direction',
      type: 'GET'
      dataType: 'script'
      data: {"language_id": $("#quiz_language_id option:selected").val()}
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Direction was changed")








