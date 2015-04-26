function Activity(){
}

Activity.updateStatus = function(e){
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
  var href = $("form", $tr).attr("action");

  $.ajax(href, {
    "method": "DELETE",
    "success": function(){
      $tr.slideUp(function(){
        $(this).remove();
      });
    }
  })
}

Activity.edit = function(e){
  e.preventDefault();
  var $td = $(this);
  $td.addClass("editing");
  $("input.edit", $td).focus();
}

Activity.updateContent = function(e){
  e.preventDefault();

  var $form = $(this)
  var href = $form.attr("action");

  $.ajax(href, {
    "method": "PATCH",
    "data": $form.serialize(),
    "success": function(response){
      var newValue = $("input.edit", $form).val();
      var $td = $form.parents("td:first");
      $td.html(newValue)
      hideEditInPlace($td);
    }
  })
}

function hideEditInPlace($td){
  $td.removeClass("editing");
}

Activity.clear = function(e){
  $("button.clear-completed").parents().find($("li.completed").addClass("hidden"));
}

Activity.show = function(e){
  $("button.show-completed").parents().find($("li.completed").removeClass("hidden"));
}

Activity.stopEdit = function(e){
  e.preventDefault();
  var $td = $(this).parents("td:first");
  hideEditInPlace($td);

  $("form.update", $td).trigger("submit")
}

function addActivityListener(){
  $("#show-activity-form").click(function(){
      $("form").show();
    });
}

function showActivityForm(){
  $(this).parents("div.view").children("div#edit-activity.hidden").removeClass("hidden")
}

function makeSelection(){
  var $form = $(this).parents("form:first")
  var href = $form.attr("action");

  $.ajax(href, {
    "method": "PATCH",
    "data": $form.serialize(),
    "success": function(response){
      var newValue = $("select", $form).val();
      var $td = $form.parents("td:first");
      $td.html(newValue)
      hideEditInPlace($td);
    }
  })
}

$(function(){
  $("form#new_activity").hide();
  $("select").addClass("edit");
  $("table.table").on("change", "input:checkbox", Activity.updateStatus);
  $("table.table").on("change", "select", makeSelection);
  $("table.table").on("change", "input", makeSelection);

  $("table.table").on("click", "button.destroy", deleteActivity);
  $("table.table").on("submit", "form.update", Activity.updateContent);
  $("table.table").on("dblclick", "td", Activity.edit);
  $("table.table").on("blur", "td input.edit", Activity.stopEdit);

  addActivityListener();
});
