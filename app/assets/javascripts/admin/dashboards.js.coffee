# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

showUsers = (selector, display) ->
  $(selector).on "click", (event) ->
  	event.preventDefault()
  	$(display).toggle()

jQuery ->
  showUsers "#most", "#most-active"
  showUsers "#more", "#more-active"