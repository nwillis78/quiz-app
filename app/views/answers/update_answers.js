$("#displayed_answers"+"<%= escape_javascript(@question_no) %>").empty()
.append("<%= escape_javascript(render(:partial => @answers)) %>")

//attempt to make answers display in the correct direction
//$(".answers_direction"+"<%= escape_javascript(@question_no) %>").style.direction = '<%=@direction%>'


