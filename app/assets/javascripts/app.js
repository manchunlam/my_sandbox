$(function() {
  'use strict';
  var items = new App.collections.Items();
  var itemListView = new App.views.ItemListView({
    el: $('#module-item-creation'), collection: items });
});
