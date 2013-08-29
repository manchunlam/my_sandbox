(function() {
  App.views.ItemView = Backbone.View.extend({
    initialize: function() {
      _.bindAll(this, 'render');
      this.model.bind('change', this.render);
    },

    render: function() {
      var template = this.options.template;
      var model = this.model;

      var id = model.get('id');
      var url = model.url();
      var name = model.get('name');

      this.$el.append(template({ name: name, url: url, id: id }));
      return this;
    }
  });
})();
