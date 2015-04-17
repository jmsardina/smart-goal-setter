function renderReplyForm(){
  $(this).parents("div:first").children("div:first").removeClass("hidden")
}

$(function(){
  $(".lv-body").on("click", "button.reply",renderReplyForm)
})
