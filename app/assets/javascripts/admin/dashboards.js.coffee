showUsers = (selector, display) ->
  $(selector).on 'click', (event) ->
    event.preventDefault()
    $(display).toggle()

jQuery ->
  showUsers '#most', '#most-active'
  showUsers '#more', '#more-active'
