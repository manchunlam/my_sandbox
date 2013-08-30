$(function() {
  'use strict';
  // initiate model
  var item = new App.models.Item({ name: 'hello world' })

  // initiate view
  var itemView = new App.views.ItemView({ el: $('ul.items'), model: item });

  $('button#add').on('click', function(event) {
    event.preventDefault();

    item.save();
  });
});
