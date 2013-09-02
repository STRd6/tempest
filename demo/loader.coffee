gistId = window.location.href.match(/gistId=(\d+)/)?[1] or 6286182

$.getJSON "https://api.github.com/gists/#{gistId}", (data, status, request) ->
  # Executing the entry point
  entryPoint = "build.js"
  program = data.files[entryPoint].content

  # Pass in context, settings, and execute program
  Function("ENV", program)
    files: data.files
