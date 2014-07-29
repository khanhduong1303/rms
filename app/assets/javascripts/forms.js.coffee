$ ->
  $(document).on 'change', '#form_category_id', ->
    params = {'id': $('#form_category_id').val()}
    $.ajax
      url: '/forms/filter'
      type: 'post'
      data: params
    return
  return

