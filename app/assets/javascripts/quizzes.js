$("#questions a.add_fields").
  data("association-insertion-position", 'before').
  data("association-insertion-node", 'this');

$('#questions').on('cocoon:after-insert',
     function() {
         console.log('in quizzes.js')
         $(".link-fields a.add_fields").
             data("association-insertion-position", 'before').
             data("association-insertion-node", 'this');
         $('.link-fields').on('cocoon:after-insert',
              function() {
                $(this).children("#question_from_list").remove();
                $(this).children("a.add_fields").hide();
              });
     });
