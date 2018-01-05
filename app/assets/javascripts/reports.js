function amountCount() {
    var amount = 0;
    $('.amount').each(function () {
        amount = amount + parseFloat($(this).text())
    });
    $('#amountcount').text(amount.toFixed(2))
}

