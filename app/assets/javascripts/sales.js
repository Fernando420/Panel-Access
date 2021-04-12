$(document).on('turbolinks:load', function() {
    $(document).ready(function(){
        localStorage.setItem('sale',JSON.stringify({"amount_total": 0, items: []}))
    })

    $("#add-member_id").on("click", function(){
        $("#member_id_sales").removeClass('hide')
    });
    
    $("#send_sale_modal").on("click", function(){
        var url = '/sales'
        sale = localStorage.getItem('sale')
        sale = JSON.parse(sale)
        sale.member_id = $('#member_id').val()
        if(sale.items.length != 0) {
            sale.items = JSON.stringify(sale.items)
            $.ajax({
                url: url,
                dataType: "json",
                method: 'POST',
                headers: {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
                data: {sale},
                success: function (response) {
                    console.log(response);
                    if(parseInt(response.code) == 200) {
                        $("#modalSuccess #message").text("Sale create successfully");
                        $("#modalSuccess").modal('show');
                        localStorage.setItem('sale',JSON.stringify({"amount_total": 0, items: []}))
                        $("#modalConfirmSale").modal('hide');
                    }else{
                        $("#modalError #body-title").text("Sale Error");
                        $("#modalError #message").text(response.message);
                        $("#modalError").modal('show');
                        $("#modalConfirmSale").modal('hide');
                    }
                    window.location.reload
                }
            });
        }else{
            $("#modalError #body-title").text("Sale Error");
            $("#modalError #message").text("Ingrese articulos para cobrar");
            $("#modalError").modal('show');
            $("#modalConfirmSale").modal('hide');
        }
    });
    
    $("#send-sale").on("click", function(){
        sale = localStorage.getItem('sale')
        sale = JSON.parse(sale)
        var member_id = $('#member_id').val()
        $("#modalConfirmSale #amount_total").text("$"+sale.amount_total);
        $("#modalConfirmSale #total_products").text(sale.items.length);
        $("#modalConfirmSale #member_id_modal").text(member_id ||= "Cliente Externo" );
        $("#modalConfirmSale").modal('show');
    });
    
    $("#remove-member_id").on("click", function(){
        $("#member_id").val(null)
        $("#member_id_sales").addClass('hide')
    });

    $(document).on('click', '.remove-product', function () {
        var barcode = $(this).data('barcode')
        var id = $(this).data('id')
        sale = localStorage.getItem('sale')
        sale = JSON.parse(sale)
        for (var i = 0; i < sale.items.length; i++) {
            if (sale.items[i]["id"] == id) {
                sale.amount_total = parseFloat(sale.amount_total) - parseFloat(sale.items[i]["amount"])
                sale.items.splice(i, 1);
                localStorage.setItem('sale', JSON.stringify(sale));
                $('#amount_total').text("$"+sale.amount_total)
            }
        }
        $('#'+barcode).remove()
    });

    $("#bar-code").on("change", function(){
        var bar_code = $(this).val()
        var headers = {'authenticity_token': $('meta[name="csrf-token"]').attr('content')}
        var url = "/products/barcode/"+bar_code
        $.get(url,headers, function(response){
            if(parseInt(response.code) == 200){
                sale = localStorage.getItem('sale')
                sale = JSON.parse(sale)
                sale.items.push({ id:response.data.id, amount: response.data.price, name: response.data.name, barcode: response.data.bar_code })
                sale.amount_total = parseFloat(response.data.price) + parseFloat(sale.amount_total)
                localStorage.setItem('sale', JSON.stringify(sale))
                $('#amount_total').text("$"+sale.amount_total)
                $("#ticket").append(
                    '<div class="ticket-list pt-3" id='+ response.data.bar_code +'>' +
                        '<div class="row">'+
                            '<div class="col-2">'+
                                '<div class="button-remove">'+
                                    '<button data-id='+ response.data.id +' data-barcode='+ response.data.bar_code +' class="btn btn-remove-ticket remove-product">X</button>'+
                                '</div>'+
                            '</div>'+
                            '<div class="col-5">'+
                                '<h1 class="name-product">Name: '+ response.data.name +'</h1>'+
                                '<h5 class="barcode-product">Bar Code: '+ response.data.bar_code +'</h5>'+
                            "</div>"+
                            '<div class="col-5">'+            
                                '<h1 class="price-product">Price: '+ response.data.price +'</h1>'+                    
                            '</div>'+
                        '</div>'+
                    '</div>'
                )
            }else{
                $("#modalError #message").text("Error Product Not Found or Product Selled");
                $("#modalError").modal('show');
            }
            $("#bar-code").val(null)
        });
    });

});

//834HFUICHIOWNIOWEHU