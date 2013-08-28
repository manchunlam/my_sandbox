var App = App || {};

$(function() {
  'use strict';
  $('button#add').on('click', function(event) {
    console.log('yay');
    var item = new App.Item({ name: 'foobar' });
    item.save()
      .done(function(model, xhr, options) {
        console.log(model);
        console.log(xhr);
        console.log(options);
      })
      .fail(function(model, xhr, options) {
        console.log(model);
        console.log(xhr);
        console.log(options);
      });
  });
});
