// // To mark activities as complete:
//   // Add a listener on the activity status checkbox (prop checked)
//   // When checked, the activity info should get crossed out
//   // change value to "0"
//   // Add class complete

// function Activity(){

// }

// Activity.updateStatus = function(){
//   var $checkbox = $(this)
//   var $form = $(this).parents
//   var href = $form.attr("action")

//   $.ajax(href, {
//     "method": "PATCH",
//     "data": $form.serialize(),
//     "success": fuction(response){
//       $checkbox.parents("li:first").toggleClass("completed");
//     }
//   })
// }
// // To edit activities in place