(function($) {
  'use strict';
  App.models.Item = Backbone.Model.extend({
    urlRoot: '/items',
    defaults: {
      name: 'hello world'
    }
  });
})(jQuery);
