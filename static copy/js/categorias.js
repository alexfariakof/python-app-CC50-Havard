$(document).ready(function () {
    $('.currency-mask').maskMoney({
        prefix: "R$ ",
        decimal: ",",
        thousands: "."
    });

    $('#tableCategoria').DataTable({
        "lengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, 'Todos'], ],
        "pageLength": -1,
        "paging": true,
        "scrollCollapse": true,
        "language": {
            "search": "Pesquisar :",
            "lengthMenu": "Mostrando _MENU_ registros por página",
            "zeroRecords": "Nada encontrado",
            "info": "Mostrando página _PAGE_ de _PAGES_",
            "infoEmpty": "Nenhum registro disponível",
            "infoFiltered": "(filtrado de _MAX_ registros no total)"
        }
    });
});

var handleSaveCategoria = function (id) {
    var _idCategoria = $('#idCategoria').val();
    var _idTipoCategoria = $('#tipoCategoria').val();
    var _descricao = $('#descricao').val();

    if (_idTipoCategoria === '0' || typeof _idTipoCategoria == "undefined" || _idTipoCategoria === '') {

        alertError('O campo tipo de categoria deve ser selecionado!');
        return false;

    }
    else if (_descricao === '' || _descricao === null || typeof _descricao == "undefined") {

        alertError('O Campo descrição deve ser preenchido!')
        return false;
    }

    if (_idCategoria === '0') { // id  = 0 do inclusão
        $.ajax({
            url: "categoriaIncluir",
            type: 'post',
            data: {
                idTipoCategoria: _idTipoCategoria,
                descricao: _descricao
            },
            beforeSend: function () {
                $('.modal').show();
            },
            complete: function (jqxhr, txt_status) {
                setTimeout(function() {
                    $('.modal').hide();
                }, 1000);
            },
            success: function (response) {
            }
        })
            .done(function (response) {
                handleNewCategoria();
                if (response.status === '200') {
                    alertSuccess('Categoria registrada com sucesso!');
                }

            })
            .fail(function (jqXHR, textStatus, msg) {
                alertError(msg);
            });
    }
    else {  // id != 0 do Alteração
        $.ajax({
            url: "categoriaAlterar",
            type: 'post',
            data: {
                idCategoria: _idCategoria,
                idTipoCategoria: _idTipoCategoria,
                descricao: _descricao,

            },
            beforeSend: function () {
                $('.modal').show();
            },
            complete: function (jqxhr, txt_status) {
                setTimeout(function() {
                    $('.modal').hide();
                }, 1000);

            },
            success: function (response) {
                if (response.status === '200') {
                    alertSuccess('Categoria altualizada com sucesso!');
                }
            }
        })
            .done(function (response) {
                $('#idCategoria').val(response.data.idCategoria);
                $('#tipoCategoria').val(response.data.idTipoCategoria);
                $('#descricao').val(response.data.descricao);
                $('#tipoCategoria').focus();
            })
            .fail(function (jqXHR, textStatus, msg) {
                alertError(jqXHR);
            });
    }
}

var handleNewCategoria = function () {
    var doc = document.querySelector('form');
    doc.method = "POST";
    doc.action = "/categorias";
    doc.submit();
}

var clearFormCategoria = function() {
    dismissAllALerts();
    $('#idCategoria').val('0');
    $('#tipoCategoria').val('0');
    $('#descricao').val('');
    $('#tipoCategoria').focus();

}

var handleListCategoria = function () {
    var doc = document.querySelector('form');
    doc.method = "POST";
    doc.action = "/categoriaList";
    doc.submit();
}

var handleEdit = function (id) {
    var doc = document.querySelector('form');
    document.querySelector('#idCategoria').value = id;
    doc.action = "/categorias";
    doc.method = "POST";
    doc.submit();
}

var handleDelete = function (element, id) {

    if (!confirm('Tem certeza que deseja excluir essa categoria?'))
        return false;
    else {
        $.ajax({
            url: "categoriaDelete",
            type: 'post',
            data: {
                idCategoria: id,
            },
            beforeSend: function () {
                $('.modal').show();

            }
        }).done(function (response) {
            if (response.status === '200') {
                dismissAllALerts();
                $(element).parent().parent().remove();

                setTimeout(function () {
                    alertSuccess('Categoria deletada com sucesso!');
                    $('.modal').hide();
                    $(window).scrollTop(top);
                }, 1000);
            }
            else if (response.status === '400') {
                alert('Todo error 400');
                $('.modal').hide();
            }
            else if (response.status === '403') {
                alert('Todo error 403');
                $('.modal').hide();
            }

            if (response.status === '403') {
                setTimeout(function () {
                    $(window).scrollTop(top);
                    alertError(response.Error);
                    $('.modal').hide();
                }, 1000);
            }
        }).fail(function (jqXHR, textStatus, msg) {
            alertError(jqXHR);
        });
    }
}

var setClassSaldo  = function(saldo) {
    if (saldo < 0) {
        $("#thSaldo").removeClass("saldoGreen").addClass("saldoRed");
        $("#tdSaldo").removeClass("saldoGreen").addClass("saldoRed");
    }
    else {
        $("#thSaldo").removeClass("saldoRed").addClass("saldoGreen");
        $("#tdSaldo").removeClass("saldoRed").addClass("saldoGreen");
    }
}

function alertSuccess(message) {
    var alertPlaceholder = document.getElementById('liveAlertPlaceholder')
    var wrapper = document.createElement('div')

    wrapper.innerHTML = '<div  class="alert alert-success d-flex align-items-center ; " role="alert"  >' +
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2" viewBox="0 0 16 16" role="img" aria-label="Warning:" > ' +
        '<path path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>    </svg> ' +
        '<symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16"></symbol>  ' +
        '<div>' + message + ' </div>' +
        '<button type="button" class="btn-close float-end" data-bs-dismiss="alert" aria-label="Close"  style="right:0;"  ></button>' +
        '</svg>' +
        '</div>';
    alertPlaceholder.append(wrapper)
}

function alertError(message) {
    var alertPlaceholder = document.getElementById('liveAlertPlaceholder')

    var wrapper = document.createElement('div')

    wrapper.innerHTML = '<div id="alertError" class="alert alert-danger  d-flex align-items-center" role="alert" >' +
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2" viewBox="0 0 16 16" role="img" aria-label="Warning:">' +
        '<path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>' +
        '</sgv>' +
        '<symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16"></symbol>' +
        '<div id="msghError">' + message + '</div>  ' +
        '<button type="button" class="btn-close " data-bs-dismiss="alert" aria-label="Close" style="position:relative;right:0; ></button>' +
        '</div>';
    alertPlaceholder.append(wrapper);
}

var dismissAllALerts = function () {
    var alertList = $('.alert')
    alertList.each(function () {
        $(this).remove();
    });
}