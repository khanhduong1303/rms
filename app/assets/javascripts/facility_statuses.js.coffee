$ ->
  $(document).on 'click', '.facility-status', ->
    $('#facility_status_facility_id').val $(this).data 'facility-id'
    return
  return

