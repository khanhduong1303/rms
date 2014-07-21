$(document).on 'change', 'select.change-active', ->
  facility_id = $(this).data('facility-id')
  status = false
  if $(this).val() is 'active'
    status = true
  else
    status = false
  params =
    id: facility_id
    active: status
  $.ajax
    url: 'facilities/change_active'
    type: 'post'
    data: params
    dataType: 'json'
    success: (data) ->
      if data.status is 'success'
        $('#notifications').html('<div class="alert alert-success alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>Status was successfully updated!</div>')
        setTimeout (->
          $("div.alert.alert-success.alert-dismissible").alert "close"
          return
        ), 1500
      else
        alert 'error'
      return
    error: ->
      alert 'fails'
      return
  return

