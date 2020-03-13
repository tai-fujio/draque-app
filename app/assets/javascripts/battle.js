$(document).ready(function () {
  $(document).on('show.bs.modal', '.modal', e => {
    const $currentModal = $(e.currentTarget);
    var zIndex = 1040 + (10 * $('.modal:visible').length);
    $currentModal.css('z-index', zIndex);
    setTimeout(function() {
      $('.modal-backdrop')
        .not('.modal-stack')
        .css('z-index', zIndex - 1)
        .addClass('modal-stack');
    }, 0);
  });
});

