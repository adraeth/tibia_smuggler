# TODO: Add a "welcome to hell" sign ; >
$(document).ready ->
  $('#step-indicator div:nth-child(1)').css('color', '#282828')
  $('#amount-picker').children().css('display', 'none')
  $('#amount-picker img').css('display', 'block')
  step = 1
  rate = 0.0
  reducible = false
  reduction_step = 0.0
  char_from_exists = false
  char_to_exists = false
  submitOrder = ->
    if char_from_exists && char_to_exists
      $('#character-to-input').prop('disabled', false)
      $('#character-from-input').prop('disabled', false)
      $('#new_order').submit()
    else
      console.log('One of parameters in submitOrder is still false')
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
  $('#previous-button').click ->
    switch step
      when 2
        $('#step-indicator div:nth-child(3)').animate({color: '#aaa'}, 400, ->
          $('#step-indicator div:nth-child(1)').animate({color: '#282828'}, 400))
        $('#amount-picker').fadeOut(-> $('#world-picker').fadeIn())
        $('#previous-button').fadeOut()
        step--
      when 3
        $('#step-indicator div:nth-child(5)').animate({color: '#aaa'}, 400, ->
          $('#step-indicator div:nth-child(3)').animate({color: '#282828'}, 400))
        $('#final-details').fadeOut(-> $('#amount-picker').fadeIn())
        $('#next-button').fadeIn()
        step--
  $('#create-order-button').click (event)->
    event.preventDefault()
    $(this).prop('disabled', true)
    $('#character-from-input').prop('disabled', true).animate({color: '#aaa'}, 200)
    $('#character-to-input').prop('disabled', true).animate({color: '#aaa'}, 200)
    if !char_from_exists
      console.log('Verifying char from.')
      $.ajax
        type: 'get'
        data: {"name" : $('#character-from-input').val(), "world" : $('#order_world_from_id option:selected').html()}
        dataType: 'jsonp'
        url: 'http://smuggler.home.pl/smuggler_ajax.php'
        success: (json) ->
          console.log('jsonp from success')
          if json.result == 'success'
            console.log('jsonp from result success')
            char_from_exists = true
            submitOrder()
          else
            console.log(json.message)
            $('#create-order-button').prop('disabled', false)
            $('#character-from-input').prop('disabled', false).animate({color: '#000'}, 200)
            $('#character-from-input').css("border-color", "red").effect('highlight', {color: '#8e0000'})
    if !char_to_exists
      console.log('Verifying char to.')
      $.ajax
        type: 'get'
        data: {"name" : $('#character-to-input').val(), "world" : $('#order_world_to_id option:selected').html()}
        dataType: 'jsonp'
        url: 'http://smuggler.home.pl/smuggler_ajax.php'
        success: (json) ->
          console.log('jsonp to success')
          if json.result == 'success'
            console.log('jsonp to result success')
            char_to_exists = true
            submitOrder()
          else
            console.log(json.message)
            $('#create-order-button').prop('disabled', false)
            $('#character-to-input').prop('disabled', false).animate({color: '#000'}, 200)
            $('#character-to-input').css("border-color", "red").effect('highlight', {color: '#8e0000'})
  $('#order_amount_to').keyup ->
    if reducible
      if $('#order_amount_to').val() >= 1000000
        correct_rate = rate - reduction_step * 3
        $('#rate-reduction-teaser').children().css({'font-weight': 'bold', 'color': '#339933'})
      else if $('#order_amount_to').val() >= 600000
        correct_rate = rate - reduction_step * 2
        $('#rate-reduction-teaser').children().css({'font-weight': 'bold', 'color': '#339933'})
        $('#rate-reduction-teaser p:last-child').css({'font-weight': 'normal', 'color': '#333333'})
      else if $('#order_amount_to').val() >= 300000
        correct_rate = rate - reduction_step
        $('#rate-reduction-teaser').children().css({'font-weight': 'normal', 'color': '#333333'})
        $('#rate-reduction-teaser p:first-child').css({'font-weight': 'bold', 'color': '#339933'})
      else
        correct_rate = rate
        $('#rate-reduction-teaser').children().css({'font-weight': 'normal', 'color': '#333333'})
    else
      correct_rate = rate
    $('#fake_amount_from').val(Math.round($('#order_amount_to').val() * ++correct_rate / 100)*100)