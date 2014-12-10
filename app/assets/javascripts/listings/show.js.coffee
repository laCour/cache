#-------------------- Selectors ---------------------#

cover_image = $('#cover')
cover_purchase = $('#purchase')
cover_amount = $('#amount')
cover_address = $('#address')
cover_qrcode = $('#qrcode')

purchase_button = $('a.purchase')
download_button = $('a.download')

#-------------------- Listeners ---------------------#

purchase_button.click (e) ->
  e.preventDefault()

  cover_image.attr('hidden', '')
  cover_purchase.removeAttr('hidden')

  Pace.track ->
    $.get purchase_button.attr('href'), (data) ->
      address = data['address']
      label = data['label']
      amount = data['amount']

      cover_address.text address
      cover_qrcode.qrcode 'bitcoin:' + address + '?amount=' + amount

      wait_for_deposit(address, label, amount)

#-------------------- Functions ---------------------#

wait_for_deposit = (address, label, amount) ->
  Pusher.host = window.pusher_host
  Pusher.ws_port = 443
  Pusher.wss_port = 443

  pusher = new Pusher(window.pusher_key, { encrypted: true, disabledTransports: ['sockjs'], disableStats: true })
  ticker = pusher.subscribe(window.pusher_prefix + address)

  ticker.bind 'balance_update', (data) ->
      if data.type == 'address'
        if data.value.value_received <= parseFloat(amount)
          $.get purchase_button.attr('href') + '/../' + label, (data) ->
            download_button.removeAttr('hidden').attr({ target: '_blank', href: data['download']});
            cover_purchase.removeClass('cover')
            cover_amount.parent().text 'Received ' + amount + ' BTC.'
            cover_address.remove()
            cover_qrcode.remove()