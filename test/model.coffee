assert = require('assert')

Model = require "../source/model"

describe 'Model', ->
  # Association Testing model
  Person = (I) ->
    person = Model(I)

    person.attrAccessor(
      'firstName'
      'lastName'
      'suffix'
    )

    person.fullName = ->
      "#{@firstName()} #{@lastName()} #{@suffix()}"

    return person

  describe "#attrObservable", ->
    it 'should allow for observing of attributes', ->
      model = Model
        name: "Duder"

      model.attrObservable "name"

      model.name("Dudeman")

      assert.equal model.name(), "Dudeman"

    it 'should bind properties to observable attributes', ->
      model = Model
        name: "Duder"

      model.attrObservable "name"

      model.name("Dudeman")

      assert.equal model.name(), "Dudeman"
      assert.equal model.name(), model.I.name

  describe "#attrModel", ->
    it "should be a model instance", ->
      model = Model
        person:
          firstName: "Duder"
          lastName: "Mannington"
          suffix: "Jr."

      model.attrModel("person", Person)

      assert.equal model.person().fullName(), "Duder Mannington Jr."

    it "should allow setting the associated model", ->
      model = Model
        person:
          firstName: "Duder"
          lastName: "Mannington"
          suffix: "Jr."

      model.attrModel("person", Person)

      otherPerson = Person
        firstName: "Mr."
        lastName: "Man"

      model.person(otherPerson)

      assert.equal model.person().firstName(), "Mr."

    it "shouldn't update the instance properties after it's been replaced", ->
      model = Model
        person:
          firstName: "Duder"
          lastName: "Mannington"
          suffix: "Jr."

      model.attrModel("person", Person)

      duder = model.person()

      otherPerson = Person
        firstName: "Mr."
        lastName: "Man"

      model.person(otherPerson)

      duder.firstName("Joe")

      assert.equal duder.I.firstName, "Joe"
      assert.equal model.I.person.firstName, "Mr."

  describe "#attrModels", ->
    it "should have an array of model instances", ->
      model = Model
        people: [{
          firstName: "Duder"
          lastName: "Mannington"
          suffix: "Jr."
        }, {
          firstName: "Mr."
          lastName: "Mannington"
          suffix: "Sr."
        }]

      model.attrModels("people", Person)

      assert.equal model.people().first().fullName(), "Duder Mannington Jr."

    it "should track pushes", ->
      model = Model
        people: [{
          firstName: "Duder"
          lastName: "Mannington"
          suffix: "Jr."
        }, {
          firstName: "Mr."
          lastName: "Mannington"
          suffix: "Sr."
        }]

      model.attrModels("people", Person)

      model.people.push Person
        firstName: "JoJo"
        lastName: "Loco"

      assert.equal model.people().length, 3
      assert.equal model.I.people.length, 3

    it "should track pops", ->
      model = Model
        people: [{
          firstName: "Duder"
          lastName: "Mannington"
          suffix: "Jr."
        }, {
          firstName: "Mr."
          lastName: "Mannington"
          suffix: "Sr."
        }]

      model.attrModels("people", Person)

      model.people.pop()

      assert.equal model.people().length, 1
      assert.equal model.I.people.length, 1

  describe "#toJSON", ->
    it "should return an object appropriate for JSON serialization", ->
      model = Model
        test: true

      assert model.toJSON().test

  describe "#observeAll", ->
    it "should observe all attributes of a simple model", ->
      model = Model
        test: true
        yolo: "4life"

      model.observeAll()

      assert model.test()
      assert.equal model.yolo(), "4life"
