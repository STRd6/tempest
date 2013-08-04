assert = require('assert')
Tempest = require('../source/tempest')

describe 'Tempest', ->
  it 'should have Models', ->
    assert(Tempest.Model)

  it 'should have Observables', ->
    assert(Tempest.Observable)
