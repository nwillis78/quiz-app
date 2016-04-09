document.getElementById("question_body").style.direction = '<%=@direction%>'
var answers = document.getElementsByClassName("answer_field")
for(var i=0; i<answers.length; i++) { 
  answers[i].style.direction = '<%=@direction%>'
}

