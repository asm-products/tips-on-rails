# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

charCount = (selector, limit, counter_display) ->
  $counter_display = $(counter_display)
  remaining = limit - $(selector).val().length
  $counter_display.text remaining + " characters remaining"
  if (remaining <= 10) 
    $counter_display.addClass("approaching-limit")
  else
    $counter_display.removeClass("approaching-limit")
  if (remaining < 0)
    $(selector).parent().addClass('has-error')
  else
    $(selector).parent().removeClass('has-error')

jQuery ->
  # Initialize the counters for Title and Description
  charCount "#tip_title", 50, ".tip-title-countdown"
  charCount "#tip_description", 250, ".tip-description-countdown"
  
  # Monitor the changes for Title and Description
  $("#tip_title, #tip_description").change ->
    charCount "#tip_title", 50, ".tip-title-countdown"
    charCount  "#tip_description", 250, ".tip-description-countdown"
  
  # Monitor typing with the Title and Description
  $("#tip_title, #tip_description").keyup ->
    charCount "#tip_title", 50, ".tip-title-countdown"
    charCount  "#tip_description", 250, ".tip-description-countdown"

  # Send the tip body to Markdown parser to generate the preview and show preview
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

  # Switch back to tip body input
  $('#write_tab').click (event) ->
    event.preventDefault()
    unless $("#write_tab").parent().hasClass("active")
      $("#write_input").show()
      $("#code_preview").hide()
      $("#code_preview_tab").parent().removeClass("active")
      $("#write_tab").parent().addClass("active")
