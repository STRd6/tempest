Model
=====



Implementation
--------------

Require AthleticSupport to give us all our nice helpers.

    require 'athletic-support'

Observable is what allows us to easily expose observable properties.

    Observable = require "./observable"

The model constructor.

    Model = (I) ->

Inherit from `Core` which is provided by AthleticSupport and keep a reference to `self`.

      self = Core(I).extend

Observe any number of attributes as simple observables. For each attribute name passed in we expose a public getter/setter method and listen to changes when the value is set.

        attrObservable: (names...) ->
          names.each (name) ->
            self[name] = Observable(I[name])

            self[name].observe (newValue) ->
              I[name] = newValue

          return self

Observe an attribute as a model. Treats the attribute given as an Observable model instance exposting a getter/setter method of the same name. The class name is infered from the property name or a class can be passed in explicitly.

        attrModel: (name, Model) ->
          Model ?= name.classify().constantize()

          model = Model(I[name])

          self[name] = Observable(model)

          self[name].observe (newValue) ->
            I[name] = newValue.I

          return self

Observe an attribute as a list of sub-models. This is the same as `attrModel` except the attribute is expected to be an array of models rather than a single one.

        attrModels: (name, Model) ->
          Model ?= name.classify().constantize()

          models = (I[name] or []).map Model

          self[name] = Observable(models)

          self[name].observe (newValue) ->
            I[name] = newValue.map (instance) ->
              instance.I

          return self

A method to create simple observables for all properties.

        observeAll: ->
          self.attrObservable Object.keys(I)...

The JSON representation of this model is kept up to date via the observable properites and resides in `I`.

        toJSON: ->
          I

Return our public object.

      return self

Export to requiring context.

    module.exports = Model
