var App = App || {};

(function($) {
  'use strict';
  App.Item = Backbone.Model.extend({
    urlRoot: '/items',
    defaults: {
      name: 'hello world'
    }
  });
})(jQuery);
