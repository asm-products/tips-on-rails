# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#code_preview_tab').click (event) ->
    event.preventDefault()
    unless $("#code_preview_tab").parent().hasClass("active") 
      url = "/tips/preview"
      body = { body: $("#tip_body").val() }
      $.post(url, body)
      $("#write_input").hide()
      $("#code_preview").show()
      $("#code_preview_tab").parent().addClass("active")
      $("#write_tab").parent().removeClass("active")

jQuery ->
  $('#write_tab').click (event) ->
    event.preventDefault()
    unless $("#write_tab").parent().hasClass("active")
      url = "/tips/preview"
      body = { body: $("#tip_body").val() }
      $.post(url, body)
      $("#write_input").show()
      $("#code_preview").hide()
      $("#code_preview_tab").parent().removeClass("active")
      $("#write_tab").parent().addClass("active")


charCount = (selector, limit, counter_display) ->
  $counter_display = $(counter_display)
  remaining = limit - $(selector).val().length
  $counter_display.text remaining + " characters remaining"
  if (remaining <= 10) 
    $counter_display.addClass("approaching-limit") 
  else
    $counter_display.removeClass("approaching-limit") 

jQuery ->
  charCount "#tip_title", 50, ".tip-title-countdown"
  charCount "#tip_description", 250, ".tip-description-countdown"
  
  $("#tip_title, #tip_description").change ->
    charCount "#tip_title", 50, ".tip-title-countdown"
    charCount  "#tip_description", 250, ".tip-description-countdown"
  
  $("#tip_title, #tip_description").keyup ->
    charCount "#tip_title", 50, ".tip-title-countdown"
    charCount  "#tip_description", 250, ".tip-description-countdown"


