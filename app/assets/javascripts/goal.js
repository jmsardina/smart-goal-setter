function completeActivity(){
  var $checkbox = $(this);
  var $form = $(this).parents("tr").children("form");
  var href = $form.attr("action");

  $.ajax(href, {
    "method": "PATCH",
    "data": $form.serialize(),
    "success": function(response){
      $checkbox.parents("tr").toggleClass("completed");
    }
  })
}

function deleteActivity(e){
  e.preventDefault();
  var $tr = $(this).parents("tr");
  var href = $tr.children("form").attr("action");

  $.ajax(href, {
    "method": "DELETE",
    "success": function(){
      $tr.slideUp(function(){
        $(this).remove();
      });
    }
  })
}

function Goal(){
}

Goal.updateStatus = function(e){
  debugger
  var $checkbox = $(this);
  var $form = $(this).parents("tr").children("form");
  var href = $form.attr("action");
  var id = $(this).data("id")
debugger
  $.ajax(href + "/" + id, {
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
  var id = $(this).data("id")

  $.ajax(href + '/' + id, {
    "method": "DELETE",
    "success": function(){
      $li.slideUp(function(){

        $(this).remove();
      });
    }
  })
}

function Invitation(){

}

Invitation.declineRequest = function(){
  var $this = $(this)
}


$(function(){
  $("table.table").on("change", "input:checkbox", completeActivity);
  $("table.table").on("click", "button.destroy", deleteActivity);


  $("ul.list").on("change", "input#goal_status", Goal.updateStatus);
  // $("ul.list-goals").on("change", "input:checkbox", Goal.updateStatus);
  $("ul.list-goals").on("click", "button.destroy", deleteGoal);
  $("div.container").on("click", "button.destroy", Invitation.declineRequest)
});
