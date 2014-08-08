// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require select2
//= require jquery_ujs
//= require bootstrap
//= require moment
//= require bootstrap-datetimepicker
//= require turbolinks
//= require jquery.remotipart
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require best_in_place
//= require best_in_place.purr
//= require_tree .
var language;
jQuery(function () {

    $.get('/bookings/getLanguage',function(data){
        language = data.val
        $('.datatable').dataTable({
            "language": {
                "url": language
            },
            // sDom: 'Rlfrtip',
            bProcessing: true,
            bDeferRender: true,
            sAjaxSource: $('.datatable').data('source'),
            sPaginationType: "full_numbers",
            bStateSave: true
        });
    });

//    add bootstrap in best_in_place
    $('.best_in_place').best_in_place()
    $(document).on('click','.in_place_class',function(){
        $('.in_place_class span form input:text').addClass('form-control input-sm');
        $('.in_place_class span form input:button').addClass('btn btn-danger');
        $('.in_place_class span form input:submit').addClass('btn btn-primary');
    });

});

