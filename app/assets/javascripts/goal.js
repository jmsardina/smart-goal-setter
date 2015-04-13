function Goal(){
}

Goal.updateStatus = function(e){
  var $checkbox = $(this);
  var $form = $(this).parents("form:first");
  var href = $form.attr("action");

  $.ajax(href, {
    "method": "PATCH",
    "data": $form.serialize(),
    "success": function(response){
      $checkbox.parents("li:first").toggleClass("completed");
    }
  })
}

function deleteGoal(e){
  e.preventDefault();
  var $li = $(this).parents("li");
  var href = $("form", $li).attr("action");

  $.ajax(href, {
    "method": "DELETE",
    "success": function(){
      $li.slideUp(function(){

        $(this).remove();
      });
    }
  })
}

$(function(){
  $("ul.list").on("change", "input:checkbox", Goal.updateStatus);
  $("ul.list").on("click", "button.destroy", deleteGoal);
});
