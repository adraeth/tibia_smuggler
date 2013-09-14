$ ->
  $('.tick-outgoing').click ->
    $(this).prop('disabled', true)
    id = $(this).parent().parent().attr('id').match(/\d{1,3}/)
    $.ajax
      type: 'post'
      url: "/admin/worlds/#{id}/toggle_outgoing_lock"
      success: (json) =>
        $(this).prop('disabled', false)

  $('.tick-incoming').click ->
    $(this).prop('disabled', true)
    id = $(this).parent().parent().attr('id').match(/\d{1,3}/)
    $.ajax
      type: 'post'
      url: "/admin/worlds/#{id}/toggle_incoming_lock"
      success: (json) =>
        $(this).prop('disabled', false)

  $('.amount-ajax-input').keyup (event) ->
    if event.which == 13
      console.log('Enter pressed.')
      $(this).prop('disabled', true)
      $.ajax
        type: 'post'
        data: { "amount" : $(this).val() }
        url: "/admin/worlds/#{$(this).attr('name')}/edit_amount"
        success: (json) =>
          $(this).val(null)
          $(this).prop('disabled', false)
          $(this).parent().prev().css("color", "#5fb404").stop().animate({color: '#333'}, 1500).html(json.amount)