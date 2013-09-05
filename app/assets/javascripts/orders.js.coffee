# TODO: Refactor spaghetti, DRY (at least the validateCharacter[..] methods)!
# TODO: Handle jsonp errors
# TODO: Handle jsonp results differently ('fail' and 'error' should not behave the same way)
$(document).ready ->

  # Initial display settings
  $('#step-indicator div:nth-child(1)').css('color', '#282828')
  $('#amount-picker').children().css('display', 'none')
  $('#amount-picker img').css('display', 'block')

  # Initial variables
  step = 1
  from_locked = true
  to_locked = true
  max_amount = 0
  rate = 0.0
  reducible = false
  reduction_step = 0.0
  char_from_exists = false
  char_to_exists = false
  char_name_regex = /^[a-zA-Z\-' ]{3,29}$/

  # Character-from input validation
  validateCharacterFrom = ->
    console.log('Validating character-from')
    if char_name_regex.test($('#character-from-input').val())
      $('#character-from-input').prop('disabled', true).css('color', '#aaa')
      console.log('Starting AJAX for character-from verification')
      $.ajax
        type: 'get'
        data: {"name" : $('#character-from-input').val(), "world" : $('#order_world_from_id option:selected').html()}
        dataType: 'jsonp'
        url: 'http://smuggler.home.pl/smuggler_ajax.php'
        success: (json) -> # TODO: Error handling!
          console.log('AJAX response for character-from received')
          if json.result == 'success'
            console.log('Character-from confirmed.')
            char_from_exists = true
            $('#character-from-input').css("border-color", "#5fb404").css("color", "#5fb404")
            submitOrder()
            return true
          else
            console.log(json.message)
            $('#create-order-button').prop('disabled', false)
            $('#character-from-input').prop('disabled', false).css('color', '#000')
            console.log('Trigger error highlighting for character-from')
            $('#character-from-input').css("border-color", "red").hide().effect('highlight', {color: '#8e0000'})
    else
      console.log('Character-from did not match regex.')
      $('#create-order-button').prop('disabled', false)
      console.log('Trigger error highlighting for character-from')
      $('#character-from-input').css("border-color", "red").hide().effect('highlight', {color: '#8e0000'})

  # Character-to input validation
  validateCharacterTo = ->
    console.log('Validating character-to')
    if char_name_regex.test($('#character-to-input').val())
      $('#character-to-input').prop('disabled', true).css('color', '#aaa')
      console.log('Starting AJAX for character-to verification')
      $.ajax
        type: 'get'
        data: {"name" : $('#character-to-input').val(), "world" : $('#order_world_to_id option:selected').html()}
        dataType: 'jsonp'
        url: 'http://smuggler.home.pl/smuggler_ajax.php'
        success: (json) -> # TODO: Error handling!
          console.log('AJAX response for character-to received')
          if json.result == 'success'
            console.log('Character-to confirmed.')
            char_to_exists = true
            $('#character-to-input').css("border-color", "#5fb404").css("color", "#5fb404")
            submitOrder()
            return true
          else
            console.log(json.message)
            $('#create-order-button').prop('disabled', false)
            $('#character-to-input').prop('disabled', false).css('color', '#000')
            console.log('Trigger error highlighting for character-to')
            $('#character-to-input').css("border-color", "red").hide().effect('highlight', {color: '#8e0000'})
    else
      console.log('Character-to did not match regex.')
      $('#create-order-button').prop('disabled', false)
      console.log('Trigger error highlighting for character-to')
      $('#character-to-input').css("border-color", "red").hide().effect('highlight', {color: '#8e0000'})

  # Called by character name input validation methods when they get their jsonp back
  # Will only submit form if both names are confirmed to exist on selected game worlds
  submitOrder = ->
    if char_from_exists && char_to_exists
      $('#character-to-input').prop('disabled', false)
      $('#character-from-input').prop('disabled', false)
      $('#new_order').submit()
    else
      console.log('One of parameters in submitOrder is still false')

  # UI control for 'next' button
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
            $('#previous-button').fadeIn()
        $.ajax
          type: 'get'
          url: "/worlds/#{$('#order_world_from_id option:selected').val()}/#{$('#order_world_to_id option:selected').val()}"
          success: (json) ->
            from_locked = json.from_locked
            to_locked = json.to_locked
            max_amount = json.to_max
        step++
      when 2
        if $('#order_amount_to').val() < 10000
          $('#order_amount_to').val(10000)
          $('#order_amount_to').keyup()
          $('#order_amount_to').hide().effect('highlight', {color: '#8e0000'})
          break
        if from_locked
          alert('The world you want to transfer from is currently locked for outgoing transfers.')
          break
        if to_locked
          alert('The world you want to transfer to is currently locked for incoming transfers.')
          break
        if $('#order_amount_to').val() > max_amount
          alert('We only have ' + max_amount + ' gold on the destination game world.')
          break
        $('#step-indicator div:nth-child(3)').animate({color: '#aaa'}, 400, ->
          $('#step-indicator div:nth-child(5)').animate({color: '#282828'}, 400))
        $('#amount-picker').fadeOut(-> $('#final-details').fadeIn())
        $('#next-button').fadeOut()
        step++

  # UI control for 'back' button
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

  # When order submit button is clicked
  $('#create-order-button').click (event)->
    event.preventDefault()
    $(this).prop('disabled', true)
    if !char_from_exists
      validateCharacterFrom()
    if !char_to_exists
      validateCharacterTo()

  # Count the amount_from input value every time keyup happens on amount_to
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