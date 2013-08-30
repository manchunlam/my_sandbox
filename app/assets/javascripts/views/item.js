(function() {
  App.views.ItemView = Backbone.View.extend({
    template: JST['items/item'],

    initialize: function() {
      _.bindAll(this, 'render');
      this.model.bind('change', this.render);
    },

    render: function() {
      var model = this.model;

      var id = model.get('id');
      var url = model.url();
      var name = model.get('name');

      this.$el.append(this.template({ name: name, url: url, id: id }));

      return this;
    },
  });
})();
