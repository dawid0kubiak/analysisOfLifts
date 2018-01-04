function amountCount() {
var amount = 0;
$('.amount').each(function() {
    amount = amount +parseFloat( $( this ).text())
});
$('#amountcount').text(amount.toFixed(2))
}

amountCount()


$('#report').bootstrapTable({
    onSearch: function (name) {
amountCount()
        console.log('refrasch')
    }

});