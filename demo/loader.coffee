gistId = window.location.href.match(/gistId=(\d+)/)?[1] or 6286182

$.getJSON "https://api.github.com/gists/#{gistId}", (data, status, request) ->
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
