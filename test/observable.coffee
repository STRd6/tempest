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

  it 'should be idempotent', ->
    o = Observable(5)

    assert.equal o, Observable(o)

  describe "#each", ->
    it "should be invoked once if there is an observable", ->
      o = Observable(5)
      called = 0

      o.each (value) ->
        called += 1
        assert.equal value, 5

      assert.equal called, 1

    it "should not be invoked if observable is null", ->
      o = Observable(null)
      called = 0

      o.each (value) ->
        called += 1

      assert.equal called, 0
