$ ->

  $('.sub-unsub li').hover(
    -> $(@).find('.btn').addClass('in'),
    -> $(@).find('.btn').removeClass('in'))

  lockButton = ($button) ->
    $button.addClass('disabled').removeClass 'btn-success btn-danger'
    $button.html "<i class='icon-refresh'></i>"

  unlockButton = ($button) ->
    $button.removeClass('disabled')

  unsubscribeButton = ($button, url) ->
    $button.data('action', 'unsubscribe')
    $button.data('original-title', 'Unsubscribe')
    $button.attr('data-url', url)
    $button.addClass('btn-danger')
    $button.html "<i class='icon-minus'></i>"
    $button.tooltip()

  subscribeButton = ($button) ->
    $button.data('action', 'subscribe')
    $button.data('original-title', 'Subscribe')
    $button.addClass('btn-success')
    $button.html "<i class='icon-plus'></i>"

  $('.sub-unsub').on 'click', "[data-action='subscribe']", (event) ->
    $button = $(@)
    url = $button.data('url')
    data =
      title_id: $button.data('title_id')
      releaser_id: $button.data('releaser_id')
    $.ajax
      type: 'POST'
      url: url
      data: data
      dataType: 'json'
      beforeSend: () -> lockButton $button
      success: (data) ->
        # console.log data.url
        # unsubscribeButton $button, data.url
        $button.parent().append "
          <span class='text-success'>
            Subscribed!
          </span>"
        $('#dash-subscriptions').load('/subscriptions') if $('#dash-subscriptions').length > 0
      error: (jqXHR, textStatus, errorThrown) ->
        subscribeButton $button
        $button.parent().append "
          <span class='text-error'>
            <strong>#{jqXHR.status}:&nbsp;</strong>
            #{errorThrown}
          </span>"
      # complete: () -> unlockButton $button

  $('.sub-unsub').on 'click', "[data-action='unsubscribe']", (event) ->
    $button = $(@)
    url = $button.data('url')
    data =
      title_id: $button.data('title_id')
      releaser_id: $button.data('releaser_id')
    $.ajax
      type: 'DELETE'
      url: url
      data: data
      dataType: 'json'
      beforeSend: () -> lockButton $button
      # complete: () -> unlockButton $button
      success: (data) ->
        $button.parent().append "
          <span class='text-info'>
            Unsubscribed!
          </span>"
        if $('#subscriptions').length > 0
          setTimeout((-> $button.closest('li').fadeOut(300)), 1500)
        # else
          # subscribeButton $button, data.url
      error: (jqXHR, textStatus, errorThrown) ->
        unsubscribeButton $button
        $button.parent().append "
          <span class='text-error'>
            <strong>#{jqXHR.status}:&nbsp;</strong>
            #{errorThrown}
          </span>"

