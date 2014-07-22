$ ->
  $(document).on 'click', '.facility-status', ->
    selector = $(this)
    $('#facility-modal').on 'shown.bs.modal', ->
      $('#facility_status_facility_id').val $(selector).data 'facility-id'
      return
    return
  return

