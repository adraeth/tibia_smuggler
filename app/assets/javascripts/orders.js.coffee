# TODO: Add a "welcome to hell" sign ; >
$(document).ready ->
  $('#step-indicator div:nth-child(1)').css('color', '#282828')
  $('#amount-picker').children().css('display', 'none')
  $('#amount-picker img').css('display', 'block')
  step = 1
  rate = 0.0
  reducible = false
  reduction_step = 0.0
  $('#next-button').click ->
    switch step
      when 1
        if $('#order_world_from_id option:selected').val() < 1
          $('#order_world_from_id').effect('highlight', {color: '#8e0000'})
          break
        if $('#order_world_to_id option:selected').val() < 1
          $('#order_world_to_id').effect('highlight', {color: '#8e0000'})
          break
        if $('#order_world_to_id option:selected').val() is $('#order_world_from_id option:selected').val()
          $('#order_world_to_id').effect('highlight', {color: '#8e0000'})
          $('#order_world_from_id').effect('highlight', {color: '#8e0000'})
          break
        $('#to-world-name').html($('#order_world_to_id option:selected').html())
        $('#from-world-name').html($('#order_world_from_id option:selected').html())
        $('#step-indicator div:nth-child(1)').animate({color: '#aaa'}, 400, ->
          $('#step-indicator div:nth-child(3)').animate({color: '#282828'}, 400))
        $('#world-picker').fadeOut(-> $('#amount-picker').fadeIn())
        $('#next-button').fadeOut()
        $.ajax
          type: 'get'
          url: "/rates/#{$('#order_world_from_id option:selected').val()}/#{$('#order_world_to_id option:selected').val()}"
          success: (json) ->
            rate = json.rate
            reducible = json.reducible
            reduction_step = json.reduction_step
            $('#amount-picker').children().fadeIn()
            if !reducible
              $('#rate-reduction-teaser').hide()
            else
              $('#rate-reduction-teaser span:first').html(reduction_step*100)
              $('#rate-reduction-teaser span:nth(1)').html(reduction_step*100*2)
              $('#rate-reduction-teaser span:nth(2)').html(reduction_step*100*3)
            $('#amount-picker img').hide()
            $('#next-button').stop(false, true)
            $('.smuggler-button').fadeIn()
        step++
      when 2
        if $('#order_amount_to').val() < 10000
          $('#order_amount_to').val(10000)
          $('#order_amount_to').keyup()
          $('#order_amount_to').hide().effect('highlight', {color: '#8e0000'})
          break
        $('#step-indicator div:nth-child(3)').animate({color: '#aaa'}, 400, ->
          $('#step-indicator div:nth-child(5)').animate({color: '#282828'}, 400))
        $('#amount-picker').fadeOut(-> $('#final-details').fadeIn())
        $('#next-button').fadeOut()
        step++
  $('#order_amount_to').keyup ->
    if reducible
      if $('#order_amount_to').val() > 1000000
        correct_rate = rate - reduction_step * 3
        $('#rate-reduction-teaser').children().css({'font-weight': 'bold', 'color': '#339933'})
      else if $('#order_amount_to').val() > 600000
        correct_rate = rate - reduction_step * 2
        $('#rate-reduction-teaser').children().css({'font-weight': 'bold', 'color': '#339933'})
        $('#rate-reduction-teaser p:last-child').css({'font-weight': 'normal', 'color': '#333333'})
      else if $('#order_amount_to').val() > 300000
        correct_rate = rate - reduction_step
        $('#rate-reduction-teaser').children().css({'font-weight': 'normal', 'color': '#333333'})
        $('#rate-reduction-teaser p:first-child').css({'font-weight': 'bold', 'color': '#339933'})
      else
        correct_rate = rate
        $('#rate-reduction-teaser').children().css({'font-weight': 'normal', 'color': '#333333'})
    else
      correct_rate = rate
    $('#fake_amount_from').val(Math.round($('#order_amount_to').val() * ++correct_rate / 100)*100)