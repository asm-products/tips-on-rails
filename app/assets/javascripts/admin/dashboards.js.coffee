# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#most").on "click", (event) ->
  	event.preventDefault()
  	$("#most-active").toggle()
   return
  
  $("#more").on "click", (event) ->
  	event.preventDefault()
  	$("#more-active").toggle()
   return
  
  $("#act").on "click", (event) ->
  	event.preventDefault()
  	$("#active").toggle()
   return 
 	
 	$("#least").on "click", (event) ->
  	event.preventDefault()
  	$("#least-active").toggle()
   return
 return