jQuery ->
  $('form').on 'click', '.remove_specials', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()