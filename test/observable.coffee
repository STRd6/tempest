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

describe "Observable Array", ->
  it "should proxy array methods", ->
    o = Observable [5]

    o.map (n) ->
      assert.equal n, 5

  it "should notify on mutation methods", (done) ->
    o = Observable []

    o.observe (newValue) ->
      assert.equal newValue[0], 1

    o.push 1

    done()

  it "should have an each method", ->
    o = Observable []

    assert o.each

  # TODO: This looks like it might be impossible
  it "should proxy the length property"

describe "Observable functions", ->
  it "should compute dependencies", (done) ->
    firstName = Observable "Duder"
    lastName = Observable "Man"

    o = Observable ->
      "#{firstName()} #{lastName()}"

    o.observe (newValue) ->
      assert.equal newValue, "Duder Bro"

      done()

    lastName "Bro"

  it "should allow double nesting", (done) ->
    bottom = Observable "rad"
    middle = Observable ->
      bottom()
    top = Observable ->
      middle()

    top.observe (newValue) ->
      assert.equal newValue, "wat"
      assert.equal top(), newValue
      assert.equal middle(), newValue

      done()

    bottom("wat")

  it "should have an each method", ->
    o = Observable ->

    assert o.each

  it "should not invoke when returning undefined", ->
    o = Observable ->

    o.each ->
      assert false

  it "should invoke when returning any defined value", (done) ->
    o = Observable -> 5

    o.each (n) ->
      assert.equal n, 5
      done()
