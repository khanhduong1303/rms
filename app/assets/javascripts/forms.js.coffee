$ ->
  $('#form_category_id').change ->
    params = {'id' : $('#form_category_id').val()}
    $.ajax
      url : '/forms/filter'
      type : 'post'
      data : params
    return
  return

