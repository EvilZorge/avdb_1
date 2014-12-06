$(document).ready(function() {
  $("#credit-kind").on('change', function() {
    var search = $("#credit-kind").val();;
    $.ajax({
      url: '/credits/set_kind',
      type: 'get',
      data: {search: search},
      success: function(result) {
        $(".credit-kind").html('');
        $(".credit-kind").html(JST['views/credit'](result.data));
      }
    })
  })

  $(".contract").on('click', function() {
    var search = this.dataset.id;;
    $.ajax({
      url: '/credits/contract_field',
      type: 'get',
      data: {search: search},
      success: function(result) {
        $(".contract-field").html('');
        $(".contract-field").html(JST['views/contract'](result));
      }
    })
  })

  $(".payment").on('click', function() {
    var search = this.dataset.id;;
    $.ajax({
      url: '/credits/payment',
      type: 'get',
      data: {search: search},
      success: function(result) {
        $(".contract-field").html('');
        $(".contract-field").html(JST['views/payment'](result));
      }
    })
  })

})  

