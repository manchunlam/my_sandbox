(function() {
  App.views.ItemView = Backbone.View.extend({
    tagName: 'li',

    className: 'item',

    template: JST['items/item'],

    initialize: function() {
      _.bindAll(this, 'render', 'saveModel');
      this.$el.on('click', $('button.item-save'), this.saveModel);
    },

    render: function() {
      var model = this.model;

      var id = model.get('id');
      var url = model.url();
      var name = model.get('name');

      this.$el.append(this.template({ name: name, url: url, id: id }));

      return this;
    },

    saveModel: function(event) {
      var view = this;
      this.model.save()
        .done(function(model, xhr, options) {
          view.$('span.item-id').text(model.id);
        });
    }
  });
})();
