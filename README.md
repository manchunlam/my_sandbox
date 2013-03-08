# i18n

## Setting the locale

In `config/application.rb`, find the line
```ruby
config.i18n.default_locale = :en
```

## View Helpers

We can translate standard form elements with just a locale file

With
```erb
<%= f.submit %>
```
and
```yaml
en:
  helpers:
    submit:
      create: "Create a %{model}"
      update: "Confirm changes to %{model}"
```

When the locale is set to `:en`, the submit button on a form will show either
_Create a Field_ or _Confirm changes to Field_ text depending on if it is a
"new" or "edit" form.

## `t` Function

The `t` function reads from locale file to get value for the translated text.

In `app/views/fields/_form.html`,
```erb
<%= f.link_to_add t('.remove_comment'), :comments %>
```

The `.` (in `.remove_comment`) means at the current scope, where scope is the
current view. With this, the `t` function will try to find the entry in the
locale file
```yaml
en:
  # fields is the controller
  fields:
    # form is the view/partial name
    form:
      remove_comment: "Remove a comment"
```

## String Functions

Some String functions are not locale sensitive, meaning that they don't
necessarily work well in languages other than English.

One example is the `upcase` method. In Turkish, for example, there are 2 "i"s.
One is "ı" (dotless i), and "i" (dotted i). The uppercase of the former is "İ"
 (pay attention to the dot on top), and the latter is "I". Normal
`string#upcase` will not work, it changes both "i"s to "I"s.

To remedy this, please use the gem `unicode_utils`. It provides methods like
```ruby
UnicodeUtils.upcase("i", :tr)
```
, which will properly change Turkish "i" to "İ"
