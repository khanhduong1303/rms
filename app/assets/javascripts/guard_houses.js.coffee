# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on 'click', '#photo-path', ->
    $('#photo-file-input').click()
    return

  $(document).on 'click', '#map-path', ->
    $('#map-file-input').click()
    return

  $(document).on 'change', '#photo-file-input', ->
    $('#photo-file-input').closest('form').submit()
    return

  $(document).on 'change', '#map-file-input', ->
    $('#map-file-input').closest('form').submit()
    return

  $(document).on 'blur', '#phone-text-input', ->
    $('#phone-text-input').closest('form').submit()
    return
  return

