# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  par = $("#bio")
  $(par).hide()
  $("#profile").click (e) ->
    $(par).toggle "slow"
    e.preventDefault()
    return
  return