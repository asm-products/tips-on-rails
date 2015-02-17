charCount = (selector, limit, counter_display) ->
  $counter_display = $(counter_display)
  remaining = limit - $(selector).val().length
  $counter_display.text remaining + ' characters remaining'
  if (remaining <= 10)
    $counter_display.addClass('approaching-limit')
  else
    $counter_display.removeClass('approaching-limit')
  if (remaining < 0)
    $(selector).parent().addClass('has-error')
  else
    $(selector).parent().removeClass('has-error')

jQuery ->
  # Initialize the counters for Title and Description
  charCount '#tip-title', 50, '.tip-title-countdown'
  charCount '#tip-description', 250, '.tip-description-countdown'
  
  # Monitor the changes for Title and Description
  $('#tip-title, #tip-description').change ->
    charCount '#tip-title', 50, '.tip-title-countdown'
    charCount  '#tip-description', 250, '.tip-description-countdown'
  
  # Monitor typing with the Title and Description
  $('#tip-title, #tip-description').keyup ->
    charCount '#tip-title', 50, '.tip-title-countdown'
    charCount  '#tip-description', 250, '.tip-description-countdown'

  # Send the tip body to Markdown parser to generate the preview
  # and show preview
  $('#code-preview-tab').click (event) ->
    event.preventDefault()
    
    unless $('#code-preview-tab').parent().hasClass('active')
      $('#code-preview-tab').addClass('load').html('loading...')
      url = '/tips/preview'
      body = { body: $('#tip_body').val() }
      $.post(url, body).then ->
        $('#code-preview-tab').addClass('preview').html('Preview')

      $('#write-input').hide()
      $('.cheatsheet').hide()
      $('#code-preview').show()
      $('#code-preview-tab').parent().addClass('active')
      $('#write-tab').parent().removeClass('active')

  # Switch back to tip body input
  $('#write-tab').click (event) ->
    event.preventDefault()
    $('#code-preview-tab').html('Preview')
    unless $('#write-tab').parent().hasClass('active')
      $('#write-input').show()
      $('.cheatsheet').show()
      $('#code-preview').hide()
      $('#code-preview-tab').parent().removeClass('active')
      $('#write-tab').parent().addClass('active')
