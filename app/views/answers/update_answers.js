$("#displayed_answers"+"<%= escape_javascript(@question_no) %>").empty()
.append("<%= escape_javascript(render(:partial => @answers)) %>")