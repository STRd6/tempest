window.Gistquire = require './gistquire'
gistId = window.location.href.match(/\?gistId=(.*)/)?[1] or 6276610

Gistquire.load gistId,
	callback: -> console.log "loaded"