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

updateCountdown = ->
  remaining = 50 - jQuery("#tip_title").val().length
  $count = jQuery(".help-block")
  $count.text remaining + " characters remaining"
  $count.css "color", (if (50 >= remaining >= 21) then "gray")
  $count.css "color", (if (21 > remaining >= 11) then "black")
  $count.css "color", (if (11 > remaining)  then "red")
  return
titleChange = ->
  $("#tip_title").change updateCountdown
  return
titleKeyup = ->
  $("#tip_title").keyup updateCountdown
  return
jQuery(document).ready ($) ->
  updateCountdown()
  titleChange()
  titleKeyup()
  jQuery(document).on "page:change", ($) ->
    updateCountdown()
    titleChange()
    titleKeyup()
    return
  return

descriptionCountdown = ->
  remaining = 250 - jQuery("#tip_description").val().length
  $countdown = jQuery(".countdown") 
  $countdown.text remaining + " characters remaining"
  $countdown.css "color", (if (250 >= remaining >= 100) then "gray")
  $countdown.css "color", (if (100 > remaining >= 11) then "black")
  $countdown.css "color", (if (11 > remaining)  then "red")
  return
descriptionChange = ->
  $("#tip_description").change descriptionCountdown
  return
descriptionKeyup = ->
  $("#tip_description").keyup descriptionCountdown
  return
jQuery(document).ready ($) ->
  descriptionCountdown()
  descriptionChange()
  descriptionKeyup()
  jQuery(document).on "page:change", ($) ->
    descriptionCountdown()
    descriptionChange()
    descriptionKeyup()
    return
  return

