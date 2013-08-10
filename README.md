Tempest
=======

Tempest uses HamlJr with Observable models to provide automagic HTML template data binding.

HamlJr is similar to haml-coffee. They both use CoffeeScript for the scripting language,
they both run in the browser, and they both output executable JavaScript. The difference is
that HamlJr templates are automatically aware of observable properties and can set up bindings
for you.

    template.haml >> HAMLjr >> template.js

Templates are functions that return HTML based on the properties of an object they are given.
Many existing templating engines return a string of text or characters but because HamlJr is
native to the browser HamlJr templates return document fragments.

    template(object) # => DocumentFragment

Invoking a template by passing a normal object works fine. The real magic comes when passing
an object that has observable properties.

    objectWithObservableProperties =
      name: Observable "HamlJr"

    template(objectWithObservableProperties)

    # Set a new value
    objectWithObservableProperties.name("Yolo")
    # Any node referencing this observable is automatically updated

A simple data object can be automatically made into an observable model:

    observableModel = Model(data).observeAll()
