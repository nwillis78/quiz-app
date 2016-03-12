
$("#displayed_answers").empty().append("<%= escape_javascript(render(:partial => @answers)) %>")

