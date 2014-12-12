#-------------------- Selectors ---------------------#

header = $('.header')

cover_trigger = $('.header.upload, .header a.cover')
cover_form = $('#cover_form')
cover_upload = $('#cover')
cover_photo_id = $('#listing_cover_photo_token')

document_trigger = $('a.document')
document_upload = $('#document')

#-------------------- Listeners ---------------------#

cover_trigger.click (e) ->
  e.stopPropagation()

  cover_upload.click()

cover_upload.change ->
  cover_form.submit()

cover_form.submit (e) ->
  e.preventDefault()

  Pace.track ->
    $.ajax
      type: 'POST'
      data: new FormData(cover_form[0])
      url: "/l/cover_upload"
      processData: false
      contentType: false
      error: -> alert('Not a valid image (wrong format or too large).')
      success: (data, status, xhr) -> 
        update_cover data

document_trigger.click (e) ->
  e.stopPropagation()

  document_upload.click()

document_upload.change ->
  if document_upload.val()
    document_trigger.text(document_upload.val().split('\\').pop())

#-------------------- Functions ---------------------#

update_cover = (data) ->
  cover_photo_id.val(data.cover_photo_id)
  header.removeClass('upload').addClass('cover')
  header.css 'background-image', 'url(' + data.url + ')'
  cover_trigger.find(".icon-camera").text("Replace Photo")
