require 'cornerstone-js'

Observable = require "./observable"

# Helper to turn a string into a class name
className = (string) ->
  string.charAt(0).toUpperCase() + string.substring(1)

Model = (I) ->
  self = Core(I).extend
    attrObservable: (names...) ->
      names.each (name) ->
        self[name] = Observable(I[name])

        self[name].observe (newValue) ->
          I[name] = newValue

    attrModel: (name, Model) ->
      Model ?= className(name).constantize()

      model = Model(I[name])

      self[name] = Observable(model)

      self[name].observe (newValue) ->
        I[name] = newValue.I

    attrModels: (name, Model) ->
      Model ?= className(name).constantize()

      models = (I[name] or []).map Model

      self[name] = Observable(models)

      self[name].observe (newValue) ->
        I[name] = newValue.map (instance) ->
          instance.I

    toJSON: ->
      I

  return self

module.exports = Model
