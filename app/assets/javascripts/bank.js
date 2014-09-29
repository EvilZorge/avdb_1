$(document).ready(function() {
  $('#datepicker').datepicker();

  $(".changeData").find(":checkbox").click(function() {
    var info = $('input:checkbox:checked').map(function() {
      return this.value;
    }).get();
    //debugger;
    $.ajax({
      url: '/bank/reload',
      type: 'get',
      data: {info: info},
      success: function(info) {
        $(".complete").html('');
        $(".complete").html(JST['views/reload'](info));
      },
    });
  });

  $('#firstAmount').on("input", function() {
    convert();
  });

  $('#firstCountry').change(function() {
    convert();
  });

  $('#secondCountry').change(function() {
    convert();
  });

  function convert() {
  var firstCountry = $('#firstCountry option:selected').text();
    var secondCountry = $('#secondCountry option:selected').text();
    var amount = $('#firstAmount').val();
    $.ajax({
      url: '/bank/convert',
      type: 'get',
      data: {amount: amount, firstCountry: firstCountry, secondCountry: secondCountry},
      success: function(data) {
        $("#secondAmount").attr('value',data.data)
      },
    });
}
})


