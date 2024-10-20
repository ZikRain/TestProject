// Please see documentation at https://learn.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
$(document).ready(function () {


    $('.popup-open-add').click(function() {
        $('.popup-fade').fadeIn();
        $('.popup-add').show();
        $('.popup-upd').hide();
		return false;
    });	

    $('.popup-open-upd').click(function () {
        $('.popup-fade').fadeIn();
        $('.popup-add').hide();
        $('.popup-upd').show();
        return false;
    });	
	
	$('.popup-close').click(function() {
		$(this).parents('.popup-fade').fadeOut();
		return false;
	});		
 
	$(document).keydown(function(e) {
		if (e.keyCode === 27) {
			e.stopPropagation();
			$('.popup-fade').fadeOut();
		}
	});
	
	$('.popup-fade').click(function(e) {
        if ($(e.target).closest('.popup-add').length == 0 && $(e.target).closest('.popup-upd').length == 0) {
			$(this).fadeOut();					
		}
	});


    $("#errorMessage").hide();

    $("#searchButton").click(function (e) {
        e.preventDefault();
        let text = $("#searchText").val();
        let url = $(this).parent().attr('action');

        $.post({
            url: url,
            data: { searchText: text },
            success: function (result) {
                var firsStr = $("#mainTable tr:first-child");
                $("#mainTable").empty();
                $("#mainTable").append(firsStr);

                if (result.length == 0) {
                    $("#errorMessage").show();
                } else {
                    $("#errorMessage").hide();
                }

                $.each(result, addProductToMainTable);
            },
            error: function (err) {
                alert(err.responseText);
                console.error(err);
            }
        });
    });

    $("#addButton").click(function (e) {
        e.preventDefault();

        let name = $("#newName").val();
        let desc = $("#newDesc").val();
        let url = $(this).parent().attr('action');

        $.post({
            url: url,
            data: { name: name, description: desc },
            success: function (result) {
                addProductToMainTable(null, result);
                $("#newName").val('');
                $("#newDesc").val('');
                $('.popup-fade').click();
            },
            error: function (err) {
                alert(err.responseText);
                console.error(err);
            }
        });
    });



    $(document).on('click', '.id_product', function () {

        let tr = $(this).parent();
        var id = tr.find('.id_product').text();
        var name = tr.find('.name_product').text();
        var desc = tr.find('.desc_product').text();

        let form_id = $("#updGuid").val(id);
        let form_name = $("#updName").val(name);
        let form_desc = $("#updDesc").val(desc);

        $('.popup-open-upd').click();
      
    });





    $("#updButton").click(function (e) {
        e.preventDefault();

        let guid = $("#updGuid").val();
        let name = $("#updName").val();
        let desc = $("#updDesc").val();
        let url = $(this).parent().attr('action');

        $.post({
            url: url,
            data: { guid: guid,name: name, description: desc },
            success: function (result) {
                addProductToMainTable(null, result);

                $("#updGuid").val('');
                $("#updName").val('');
                $("#updDesc").val('');

                $('.popup-fade').click();

                $("#searchButton").click();
            },
            error: function (err) {
                alert(err.responseText);
                console.error(err);
            }
        });
    });




    function addProductToMainTable(index, product) {
        let sep = '-';

        $("#mainTable").append(
            `<tr>
                <td class="id_product">${product.id}</td>
                <td class="name_product">${product.name}</td>
                <td class="desc_product">${product.description == null || product.description == "" ? sep : product.description}</td>
            </tr>
            `
        )
    }


});