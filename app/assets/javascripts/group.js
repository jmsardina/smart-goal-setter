// function validateForm(e){
//   e.preventDefault();
//   e.stopPropagation();

//   if($(this).parents("form:first").children("input:text").val ===  "") {
//     $(this).prop('disabled', true);
//   } else {
//     // $(this).prop('disabled', false);  
//     // $(this).unbind("input:submit").submit() 
//     // function(e){ return true; } 
//     function(){$(this).unbind("click").submit()}
//   };
// }

// $(function(){
//   $("div#group-boards").on("click", "input:submit", validateForm);
// });