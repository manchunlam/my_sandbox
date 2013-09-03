# Sandbox Application

This is a sandbox application to test various Rails features, gems, interaction
with Web Services, etc. The `master` branch will always remain a "minimal"
application.

# Topic: Backbone

1. [Javascript Functions Explained](#javascript-functions-explained)
2. [Setting up Backbone](#setting-up-backbone)
3. [Backbone Model](#backbone-model)
4. [Backbone View (Element)](#backbone-view-element)
5. [Backbone Collection](#backbone-collection)
6. [Backbone View (Collection)](#backbone-view-collection)

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
4. To use JST, the gem `ejs` is needed in the Rails app.
5. For asset pipeline to work,
    1. The templates path must be added to `config.assets.paths`
    2. Require templates directory in `application.js`

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

## Backbone View (Element)

An Element View is designed to react to __only__ its associated model. The
golden rules are

1. Listen to model events to know __when__ to change itself
2. Contains __only__ display logic, and __only__ affects itself
3. Changes that are __not__ within itself, must be issued through `event`
triggers

    This is assuming some other components and listening to this Element View,
    and react accordingly.

Basically, Element View __only deals with itself__.

### Coding Conventions

1. Always contains a `render()` method
2. `render()` always ends with

    ```javascript
    return this;
    ```
3. Make sure `this` in all methods refer to itself.

    ```javascript
    _.bindAll(this, 'render', 'otherMethod');
    ```
4. Use JST instead of inline HTML. Pass in a template, or use
`JST['my_view']` inside `render()`. For example,

    ```javascript
    new ItemView({ template: JST['items/item'] });
    ```

    This will tell `ItemView` to render a template residing in
    `app/assets/templates/items/item` with its data.

5. Pass in `el` instead of having the `el` selector hardcoded inside the View
definition, so the "Immediate" pattern can be used for faster page loading.

### Variation

1. If you know the View's template never changes, you can always bake it in

    ```javascript
    template: JST['items/item'],

    render: function() {
      this.$el.append(this.template({ name: 'something' }));
      return this;
    }
    ```

    See branch `jl/backbone-view-built-in-template` for an example.

## Backbone Collection

1. Model can be added, and saved immediately (`create`); or without being saved
(`add`)
2. Collection have a ton of events to signal a change in itself, or individual
models
3. Collection __does not__ have its own `save` method.
    1. Models are either individually saved to the backend, or
    2. Serialize the whole collection, and send the JSON to the server

### Coding Convention

1. The `Backbone.Collection.url` property negates the necessity of
`Backbone.Model.urlRoot`
    * Let's say `ItemsCollection` has a `url` "/items", then its model will
      be saved as a POST to "/items"
2. It must have a `model` property

## Backbone View (Collection)

1. Collection View is usually the parent view, containing multiple Element
Views.
2. It listens to the `add` event on its associated `collection`, and render
Element views for each.

### Coding Convention

1. `el`:
    1. Element View: specify `tagName`, `className`, and let Backbone __create__
the `el` element (see `views/item.js`)
    2. Collection View: either pass in a selector after DOM ready
(see `app.js`); or specify `el` in the class definition, and let Backbone
create it (see the Backbone Todo example)
2. `Backbone.Model.save()`
    1. Use Backbone `sucess` (or `error`) callbacks if you want the returned
`model` to be a `Backbone.Model`
    2. Use the jQuery `done` (or `fail`) callback chain if you want the returned
`model` to be exactly what the server returns to you (no Backbone stuff). See
`views/items.js` for an example
