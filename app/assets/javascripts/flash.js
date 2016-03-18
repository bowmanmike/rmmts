$(document).on('ready page:load', function() {
  var hideFlash = function() {
    var flash = $('.flash');
    if (flash.hasClass('alert') || flash.hasClass('notice')) {
      flash.removeClass('alert').removeClass('notice');
    }
  }

  $(document).ajaxComplete(function() {
    setTimeout(hideFlash, 10000);
  })
})
