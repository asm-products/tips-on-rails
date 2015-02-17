$(document).on 'page:change', ->
  par = $("#bio")
  $(par).hide()
  $("#profile").click (e) ->
    $(par).toggle "slow"
    e.preventDefault()
    return
  return