assert = require('assert')

Observable = require "../source/observable"

describe 'Observable', ->
  it 'should create an observable for an object', ->
    n = 5

    observable = Observable(n)

    assert.equal(observable(), n)

  it 'should have an observe method', ->
    assert Observable().observe

  it 'should fire events when setting', ->
    string = "yolo"

    observable = Observable(string)
    observable.observe (newValue) ->
      assert.equal newValue, "4life"

    observable("4life")

  describe '.lift', ->
    it 'should treat functions as simple values', ->
      observable = Observable.lift(-> "yolo")

      assert.equal observable(), "yolo"

    it 'should keep observables unchanged', ->
      observable = Observable("yolo")
      lifted = Observable.lift observable

      assert.equal lifted, observable
