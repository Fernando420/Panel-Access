
$(document).on('turbolinks:load', function() {

    $("#access-client").on("click", function(){
        var id = $(this).data('id')
        var headers = {'authenticity_token': $('meta[name="csrf-token"]').attr('content')}
        var url = "access/create/"+id
        $.post(url,headers, function(response){
            if(parseInt(response.code) == 200) {
                $("#modalAccess #body").text("Successfully");
                var date = Date.parse(response.data.created_at)
                date = new Date(date);
                $("#modalAccess #date-access").text(date.toDateString());
                $("#modalAccess #hour-access").text(date.getHours()+":"+date.getMinutes());
                $("#modalAccess #user-access").text(response.data.user.email);
                $("#modalAccess #client-access").text(response.data.client.email);
                $("#modalAccess").modal('show');
            }else{
                $("#modalError #body").text("Error");
                $("#modalError #body-down").text();
                $("#modalError").modal('show');
            }
        });
    });

});