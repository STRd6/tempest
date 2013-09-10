Tempest = require('./tempest')
Object.extend window, Tempest

Object.extend window,
  styl: require 'styl'
  marked: require 'marked'
  HAMLjr: require 'haml-jr'
