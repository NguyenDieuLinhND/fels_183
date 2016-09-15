var countdown = function() {
  $('#clock').countdown({
    until: $('#remaining_time').val(),
    format: 'HMS',
    onExpiry: function() {
      alert(I18n.t("js.alert"));
      $('.btn-save').trigger('click');
      $('.btn-save').hidden();
    }
  });
}

document.addEventListener('turbolinks:load', countdown);
$(document).on('page:update', countdown);
