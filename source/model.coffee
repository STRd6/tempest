Observable = require "./observable"

# Helper to turn a string into a class name
className = (string) ->
  string.charAt(0).toUpperCase() + string.substring(1)

Model = (I) ->
  self = Core(I).extend
    attrObservable: (names...) ->
      names.each (name) ->
        # TODO: Write to I property from observable
        # something like: Observable.observe(I, name)
        # to set up a getter/setter
        # In addition we could listen to writes to I
        # property as well
        self[name] = Observable(I[name])

    attrModel: (name, Model) ->
      Model ?= className(name).constantize()

      model = Model(I[name])

      # TODO: Setter
      # TODO: Observable
      self[name] = ->
        model

    attrModels: (name, Model) ->
      Model ?= className(name).constantize()

      models = (I[name] or []).map Model

      # TODO: Setter?
      # TODO: Observable array of models
      self[name] = ->
        models

  return self

module.exports = Model
