Observable
==========

    require 'athletic-support'

Observable constructor.

    Observable = (value) ->

Return the object if it is already an observable object.

      return value if typeof value?.observe is "function"

Maintain a set of listeners to observe changes.

      listeners = []

Helper to notify each observer of changes.

      notify = (newValue) ->
        listeners.each (listener) ->
          listener(newValue)

Our observable function, stored as a reference to self.

      self = (newValue) ->

When called with zero arguments it is treated as a getter. When called with one argument it is treated as a setter.

        if arguments.length > 0

Changes to the value will trigger notifications.

          if value != newValue
            value = newValue

            notify(newValue)

The value is always returned.

        return value

TODO: If value is a function compute dependencies and listen to observables that it depends on

Methods that all observables share.

      Object.extend self,

Add a listener for when this object changes.

        observe: (listener) ->
          listeners.push listener

This `each` iterator is similar to [the Maybe monad](http://en.wikipedia.org/wiki/Monad_&#40;functional_programming&#41;#The_Maybe_monad) in that our observable may contain a single value or nothing at all.

        each: (args...) ->
          if value?
            [value].each(args...)

TODO: Add a delayed/debounced proxy

If value is array hook into array modification events to keep things up to date.

      if Array.isArray(value)
        Object.extend self,
          each: (args...) ->
            value.each(args...)

          map: (args...) ->
            value.map(args...)

          remove: (item) ->
            ret = value.remove(item)

            notify(value)

            return ret

          push: (item) ->
            ret = value.push(item)

            notify(value)

            return ret

          pop: ->
            ret = value.pop()

            notify(value)

            return ret

      return self

Export `Observable`

    module.exports = Observable
