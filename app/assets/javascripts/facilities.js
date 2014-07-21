

$(document).on("change" , "select.change-active" , function(){
var fid = $(this).data('id');
var active = false ;
if ($(this).val() == "Active")
	{ 
		active = true ;
     }
else {
         active = false; 
      }

      param = {
      	"id" : fid ,
      	"active" : active
      } ;
 $.ajax({
 	url : "facilities/change_active" ,
 	type : "post" ,
 	data: param ,
 	dataType: "json",
 	success: function(data){alert('Change Active Successfully');} ,
 	error: function(){alert("fails")}
 });

});