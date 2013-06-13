// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
  $('#foo').click(function(event) {
    event.preventDefault();

    var href = $(this).attr('href');
    console.log(href);

    var request = $.ajax({
      type: 'DELETE',
      url: href,
      dataType: 'json'
    });

    request.done(function() {
      alert('User Deleted!');
    });
  });
});
