{parser, compile, util} = HAMLjr = require('haml-jr')

Tempest = require('./tempest')
Object.extend window, Tempest

window.styl = require('styl')

window.HAMLjr = HAMLjr
window.parser = parser

window.Gistquire = require './gistquire'
