(function() {
  App.collections.Items = Backbone.Collection.extend({
    url: '/items',
    model: App.models.Item
  });
})();
