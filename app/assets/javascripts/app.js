$(function() {
  'use strict';
  var items = new App.collections.Items();
  var itemListView = new App.views.ItemListView({
    el: $('#module-item-creation'), collection: items });
  // // initiate collection
  // var items = new App.collections.Items

  // // initiate and add model to collection
  // items.add({ name: 'holy moly' });

  // // get added item from collection
  // var item = items.findWhere({ name: 'holy moly' });

  // // initiate view
  // var itemView = new App.views.ItemView({ el: $('ul.items'), model: item,
  //   template: JST['items/item'] });

  // $('button#add').on('click', function(event) {
  //   event.preventDefault();

  //   item.save();
  // });
});
