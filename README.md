# Sandbox Application

This is a sandbox application to test various Rails features, gems, interaction
with Web Services, etc. The `master` branch will always remain a "minimal"
application.

# Topic: Backbone

1. [Javascript Functions Explained](#javascript-functions-explained)
2. [Setting up Backbone](#setting-up-backbone)
3. [Backbone Model](#backbone-model)

## Javascript Functions Explained

What is the difference between the following?

1. Document ready

    ```javascript
    $(function() {
      console.log('You will see me once the page DOM is done loading');
    });
    ```

2. Immediate

    ```javascript
    (function() {
      console.log('You will see me the second the parser finishes parsing me');
    })();
    ```

### I. Document Ready

This pattern guarantees that any code inside the `function()` block only runs
after the DOM is done loading. This implies that all DOM elements are ready
for selecting (e.g. $('#my-div') will not be `undefined` if it exists on the
page)

### II. Immediate

This pattern guarantees that any code inside the `function()` block immediately
runs after the browser parser gets to it. Since it __does not__ wait for DOM
complete, it is way faster compared to "Document Ready" pattern.

__CAVEAT__
Because DOM-ready is __NOT__ guaranteed, any function that depends on
__selector__ should never go inside an "Immediate" pattern.

### III. Variation on Immediate

You will sometimes see the following

```javascript
(function($) {
  console.log('$ is SET to represent "jQuery" object');
})(jQuery);
```

This variation of the Immediate pattern is a safe-guard against other code
overriding the `$` object. It guarantees that, __within the function block__,
`$` is equivalent to the `jQuery` object.

## Setting up Backbone

1. Use a global variable to hold anything application related. In this branch,
the application namespace is `App`. The common way to create such namespace is

    ```javascript
    var App = App || {};
    ```
2. Any variables inside the application should be set with the above namespace,
sub-namespaces are used to group similar components together. For example, all
Backbone models are grouped under the `App.models` container.

    ```javascript
    App.models.Item = Backbone.Model.extend({});
    ```

    The above defined an `Item` model under the namespace `App.model`. When we
    need an "item" inside our application, we initialize it with

    ```javascript
    new App.models.Item({ name: 'foobar' });
    ```
3. Since namespaces are needed for Backbone model, collection, view, etc
definition, we put the namespace definitions into `bootstrap-app.js`. This JS
file is loaded __before__ any application javascripts (not including external
libraries)

    > bootstrap-app.js

    ```javascript
    var App = App || {};
    App.models = App.models || {};
    ```
3. Order of javascript `require` in `application.js` matters! A snippet from
`application.js`

    ```javascript
    //= require underscore
    //= require backbone
    //= require bootstrap-app
    //= require_tree ./models
    //= require app
    ```
    * `backbone.js` is dependent on `underscore.js`, therefore `underscore`
    __must__ preceed `backbone`
    * Backbone models require the presence `App` and `App.models` namespace,
    therefore, `bootstrap-app` is loaded before `models`
    * `app.js` initializes a Backbone model, therefore the model definition
    must be required beforehand

## Backbone Model

This branch demonstrates how to save a `Backbone.Model` to a Rails backend.

1. A Backbone Model is created by extending `Backbone.Model`
2. The `urlRoot` property specifies where the "save" POST to

    ```javascript
    urlRoot: '/items'
    ```

    The above means a POST will be made to `/items` with data structure like

    ```javascript
    { name: 'foobar',
      item: { name: 'foobar' }
    }
    ```
3. The `save()` method can be chained with success (`done`), and failure
    (`fail`) callbacks.

    ```javascript
    item.save()
      .done(function(model, xhr, options) {
      });
    ```
