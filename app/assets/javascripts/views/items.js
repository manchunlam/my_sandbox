(function() {
  App.views.ItemListView = Backbone.View.extend({
    events: {
      'click button#add-item': 'addOnClick'
    },

    initialize: function() {
      var collection = this.collection;

      collection.on('add', this.showAddedModel, this);
    },

    render: function() {
      return this;
    },

    addOnClick: function() {
      var $nameBox = this.$('input#item-name');
      var name = $nameBox.val();

      this.collection.add({ name: name });
    },

    showAddedModel: function(model, collection, options) {
      var itemView = new App.views.ItemView({ model: model });
      this.$('ul.items').append(itemView.render().el);
    }
  });
})();
