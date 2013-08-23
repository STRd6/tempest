{parser, compile, util} = HAMLjr = require('haml-jr')

Tempest = require('./tempest')
Object.extend window, Tempest

window.styl = require('styl')

window.HAMLjr = HAMLjr
window.parser = parser

window.Gistquire = require './gistquire'
Gistquire.onload() # Init access token stuff

gistId = window.location.href.match(/\?gistId=(.*)/)?[1] or 6286182

Gistquire.get gistId, (data, status, request) ->
  console.log data

  # Executing the entry point
  entryPoint = "build.js"
  program = data.files[entryPoint].content
  # Pass in context and settings here
  Function("ENV", program)(
    gist: data
    $root: $('body')
    request: request
  )
