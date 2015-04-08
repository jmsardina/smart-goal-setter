// To mark activities as complete:
  // Add a listener on the activity status checkbox (prop checked)
  // When checked, the activity info should get crossed out
  // change value to "0"
  // Add class complete
function Activity(){
}

Activity.updateContent = function(e){
  e.preventDefault();

  var $form = $(this)
  var href = $form.attr("action");

  $.ajax(href, {
    "method": "PATCH",
    "data": $form.serialize(),
    "success": function(response){
      var newLabelValue = $("input.edit", $form).val();
      var $li = $form.parents("li:first");
      $("label", $li).html(newLabelValue)
      hideEditInPlace($li);
    }
  })
}

Activity.updateStatus = function(e){
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

Activity.edit = function(e){
  e.preventDefault();
  var $li = $(this).parents("li:first");
  $li.addClass("editing");
  $("input.edit", $li).focus();
}

function hideEditInPlace($li){
  $li.removeClass("editing");
}

Activity.stopEdit = function(e){
  e.preventDefault();
  var $li = $(this).parents("li:first");
  hideEditInPlace($li);

  $("form.update", $li).trigger("submit")
}

$(function(){
  $("ul.list").on("change", "input:checkbox", Activity.updateStatus);
  $("ul.list").on("submit", "form.update", Activity.updateContent);
  $("ul.list").on("dblclick", "li label", Activity.edit);
  $("ul.list").on("blur", "li input.edit", Activity.stopEdit);
});