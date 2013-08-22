module.exports =
  accessToken: null

  # Calling auth will redirect to github for authentication
  auth: ->
    url = 'https://github.com/login/oauth/authorize?client_id=bc46af967c926ba4ff87&scope=gist,user:email'

    window.location = url

  # Call onload to check for the code returned from github authentication
  # and to get our access token from our authorization app.
  onload: ->
    # TODO: Namespace local storage key

    if code = window.location.href.match(/\?code=(.*)/)?[1]
      $.getJSON "https://hamljr-auth.herokuapp.com/authenticate/#{code}", (data) =>
        if token = data.token
          @accessToken = token
          localStorage.authToken = token

    if localStorage.authToken
      @accessToken = localStorage.authToken

  update: (id, data, callback) ->
    url = "https://api.github.com/gists/#{id}"

    if @accessToken
      url += "?access_token=#{@accessToken}"

    $.ajax
      url: url
      type: "PATCH"
      dataType: 'json'
      data: JSON.stringify(data)
      success: callback

  create: (data, callback) ->
    url = "https://api.github.com/gists"

    if @accessToken
      url += "?access_token=#{@accessToken}"

    $.ajax
      url: url
      type: "POST"
      dataType: 'json'
      data: JSON.stringify(data)
      success: callback

  get: (id, callback) ->
    if @accessToken
      data = access_token: @accessToken
    else
      data = {}

    $.getJSON "https://api.github.com/gists/#{id}", data, callback

  api: (path, callback) ->
    if @accessToken
      data = access_token: @accessToken
    else
      data = {}

    $.getJSON "https://api.github.com/#{path}", data, callback

  load: (id, {file, callback}) ->
    file ?= "build.js"

    @get id, (data) ->
      Function(data.files[file].content)()

      callback()
