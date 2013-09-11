$ ->
  class OrderFormUI

    # Initial parameters
    form_ui_step: 1
    world_from_locked: true
    world_to_locked: true
    max_allowed_amount: 0
    exchange_rate: 0.0
    exchange_rate_reducible: false
    reduction_step: 0.0
    char_from_exists: false
    char_to_exists: false
    char_name_regex: /^[a-zA-Z\-' ]{3,29}$/

    apply_display_settings: ->
      $('#step-indicator div:nth-child(1)').css('color', '#282828')
      $('#amount-picker').children().css('display', 'none')
      $('#amount-picker img').css('display', 'block')

    validate_character: (from) ->
      input_field = if from then $('#character-from-input') else $('#character-to-input')
      input_value = input_field.val()
      selected_world = if from then $('#order_world_from_id option:selected').html() else $('#order_world_to_id option:selected').html()
      if @char_name_regex.test input_value
        console.log(input_value + ' is a valid character name!')
        $.ajax
          type: 'get'
          data: { "name": input_value, "world": selected_world }
          dataType: 'jsonp'
          url: 'http://smuggler.home.pl/smuggler_ajax.php'
          success: (json) =>
            console.log('Received AJAX response.')
            if json.result == 'success'
              console.log(input_value + ' exists on selected game world.')
              if from then @char_from_exists = true else @char_to_exists = true
              input_field.css("border-color", "#5fb404").css("color", "#5fb404")
              @submit_order()
              return true
            else if json.result == 'error'
              alert(json.message)
            else
              console.log(json.message)
              $('#create-order-button').prop('disabled', false)
              input_field.prop('disabled', false).css('color', '#000').css("border-color", "red").hide().effect('highlight', {color: '#8e0000'})
      else
        console.log(input_value + ' is not a valid character name!')
        $('#create-order-button').prop('disabled', false)
        input_field.css("border-color", "red").hide().effect('highlight', {color: '#8e0000'})

    validate_amount: ->
      if $('#order_amount_to').val() < 10000
        $('#order_amount_to').val(10000)
        $('#order_amount_to').keyup()
        $('#order_amount_to').hide().effect('highlight', {color: '#8e0000'})
        console.log('Amount to is too low.')
        return false
      if @world_from_locked
        alert('The world you want to transfer from is currently locked for outgoing transfers.')
        return false
      if @world_to_locked
        alert('The world you want to transfer to is currently locked for incoming transfers.')
        return false
      if $('#order_amount_to').val() > @max_allowed_amount
        alert('We only have ' + @max_allowed_amount + ' gold on the destination game world.')
        return false
      console.log('Amount validated successfully.')
      return true

    get_world_locks_and_amount: ->
      console.log('Checking world locks and maximum allowed amount.')
      $.ajax
        type: 'get'
        url: "/worlds/#{$('#order_world_from_id option:selected').val()}/#{$('#order_world_to_id option:selected').val()}"
        success: (json) =>
          @world_from_locked = json.from_locked
          @world_to_locked = json.to_locked
          @max_allowed_amount = json.to_max

    get_rates: ->
      console.log('Getting rates for selected worlds.')
      $.ajax
        type: 'get'
        url: "/rates/#{$('#order_world_from_id option:selected').val()}/#{$('#order_world_to_id option:selected').val()}"
        success: (json) =>
          console.log('Received JSON with applied rates')
          @exchange_rate = json.rate
          @exchange_rate_reducible = json.reducible
          @reduction_step = json.reduction_step
          $('#amount-picker').children().fadeIn()
          unless @exchange_rate_reducible
            $('#rate-reduction-teaser').hide()
          else
            $('#rate-reduction-teaser span:first').html(@reduction_step*100)
            $('#rate-reduction-teaser span:nth(1)').html(@reduction_step*100*2)
            $('#rate-reduction-teaser span:nth(2)').html(@reduction_step*100*3)
          $('#amount-picker img').hide()
          $('#previous-button').fadeIn()

    validate_worlds: ->
      if $('#order_world_from_id option:selected').val() < 1
        $('#order_world_from_id').effect('highlight', {color: '#8e0000'})
        console.log('World from is not selected.')
        return false
      if $('#order_world_to_id option:selected').val() < 1
        $('#order_world_to_id').effect('highlight', {color: '#8e0000'})
        console.log('World to is not selected.')
        return false
      if $('#order_world_to_id option:selected').val() is $('#order_world_from_id option:selected').val()
        $('#order_world_to_id').effect('highlight', {color: '#8e0000'})
        $('#order_world_from_id').effect('highlight', {color: '#8e0000'})
        console.log('World from and to are the same.')
        return false
      $('#to-world-name').html($('#order_world_to_id option:selected').html())
      $('#from-world-name').html($('#order_world_from_id option:selected').html())
      console.log('World have been validated successfully.')
      return true

    update_amount_from_and_rates: ->
      if @exchange_rate_reducible
        console.log('Rate is reducible.')
        if $('#order_amount_to').val() >= 1000000
          correct_rate = @exchange_rate - @reduction_step * 3
          $('#rate-reduction-teaser').children().css({'font-weight': 'bold', 'color': '#339933'})
        else if $('#order_amount_to').val() >= 600000
          correct_rate = @exchange_rate - @reduction_step * 2
          $('#rate-reduction-teaser').children().css({'font-weight': 'bold', 'color': '#339933'})
          $('#rate-reduction-teaser p:last-child').css({'font-weight': 'normal', 'color': '#333333'})
        else if $('#order_amount_to').val() >= 300000
          correct_rate = @exchange_rate - @reduction_step
          $('#rate-reduction-teaser').children().css({'font-weight': 'normal', 'color': '#333333'})
          $('#rate-reduction-teaser p:first-child').css({'font-weight': 'bold', 'color': '#339933'})
        else
          correct_rate = @exchange_rate
          $('#rate-reduction-teaser').children().css({'font-weight': 'normal', 'color': '#333333'})
      else
        console.log('Rate is not reducible.')
        correct_rate = @exchange_rate
      $('#fake_amount_from').val(Math.round($('#order_amount_to').val() * ++correct_rate / 100)*100)

    next_step: ->
      switch @form_ui_step
        when 1
          if @validate_worlds()
            @get_world_locks_and_amount()
            @get_rates()
            $('#world-picker').fadeOut(-> $('#amount-picker').fadeIn())
            $('#step-indicator div:nth-child(1)').animate({color: '#aaa'}, 400, ->
              $('#step-indicator div:nth-child(3)').animate({color: '#282828'}, 400))
            @form_ui_step++
          break
        when 2
          if @validate_amount()
            $('#amount-picker').fadeOut(-> $('#final-details').fadeIn())
            $('#next-button').fadeOut()
            $('#step-indicator div:nth-child(3)').animate({color: '#aaa'}, 400, ->
              $('#step-indicator div:nth-child(5)').animate({color: '#282828'}, 400))
            @form_ui_step++
          break

    previous_step: ->
      switch @form_ui_step
        when 2
          $('#step-indicator div:nth-child(3)').animate({color: '#aaa'}, 400, ->
            $('#step-indicator div:nth-child(1)').animate({color: '#282828'}, 400))
          $('#amount-picker').fadeOut(-> $('#world-picker').fadeIn())
          $('#previous-button').fadeOut()
          @form_ui_step--
          break
        when 3
          $('#step-indicator div:nth-child(5)').animate({color: '#aaa'}, 400, ->
            $('#step-indicator div:nth-child(3)').animate({color: '#282828'}, 400))
          $('#final-details').fadeOut(-> $('#amount-picker').fadeIn())
          $('#next-button').fadeIn()
          @form_ui_step--
          break

    submit_form: (button) ->
      button.prop('disabled', true)
      unless @char_from_exists
        @validate_character(true)
      unless @char_to_exists
        @validate_character()

    submit_order: ->
      if @char_from_exists && @char_to_exists
        $('#character-to-input').prop('disabled', false)
        $('#character-from-input').prop('disabled', false)
        $('#new_order').submit()
      else
        console.log('One of parameters in submitOrder is still false')


  form = new OrderFormUI()
  form.apply_display_settings()

  $('#next-button').click ->
    form.next_step()

  $('#previous-button').click ->
    form.previous_step()

  $('#create-order-button').click (event) ->
    event.preventDefault()
    form.submit_form($(this))

  $('#order_amount_to').keyup ->
    form.update_amount_from_and_rates()
