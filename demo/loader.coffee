{parser, compile, util} = HAMLjr = require('haml-jr')

Tempest = require('./tempest')
Object.extend window, Tempest

window.styl = require('styl')

window.HAMLjr = HAMLjr
window.parser = parser

window.Gistquire = require './gistquire'
Gistquire.onload() # Init access token stuff

gistId = window.location.href.match(/\?gistId=(.*)/)?[1] or 6286182

Gistquire.get gistId, (data) ->
  console.log data

  # Caching our result so we can use the source in our running context
  Gistquire.Gists ||= {}
  Gistquire.Gists[gistId] = data

  # Apply the styles
  if styleContent = data.files["style.css"]?.content
    $('head').append $("<style>",
      html: styleContent
    )

  # Executing the entry point
  entryPoint = "build.js"
  program = data.files[entryPoint].content
  # TODO: Could pass in context and settings here
  Function("gistId", program)(gistId)
