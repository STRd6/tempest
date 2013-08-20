{parser, compile, util} = HAMLjr = require('haml-jr')
window.Gistquire = require './gistquire'
styl = require('styl')

# We depend on cornerstone, but let tempest require it so as not to
# double up
TextEditor = require('./text_editor')
Tempest = require('./tempest')
Object.extend window, Tempest

window.HAMLjr = HAMLjr
window.parser = parser

rerender = (->
  if location.search.match("embed")
    selector = "body"
  else
    selector = "#preview"

  # HACK for embedded
  return unless $("#template").length

  [coffee, haml, style] = editors.map (editor) -> editor.text()

  try
    data = Function("return " + CoffeeScript.compile("do ->\n" + util.indent(coffee), bare: true))()
    $("#errors p").eq(0).empty()
  catch error
    $("#errors p").eq(0).text(error)

  try
    ast = parser.parse(haml + "\n")
    template = Function("return " + compile(ast, compiler: CoffeeScript))()
    $("#errors p").eq(1).empty()
    $("#debug code").eq(1).text(template)
  catch error
    $("#errors p").eq(1).text(error)

  try
    style = styl(style, whitespace: true).toString()
    $("#errors p").eq(2).empty()
  catch error
    $("#errors p").eq(2).text(error)


  if template? and data?
    try
      fragment = template(data)

      $(selector)
        .empty()
        .append(fragment)
        .append("<style>#{style}</style>")

    catch error
      $("#errors p").eq(1).text(error)

).debounce(100)

postData = ->
  [data, template, style] = editors.map (editor) ->
    editor.text()

  public: true
  files:
    data:
      content: data
    template:
      content: template
    style:
      content: style

# TODO: Remote sample repos
save = ->
  Gistquire.create postData(), (data) ->
    location.hash = data.id

load = (id) ->
  Gistquire.get id, (data) ->
    ["data", "template", "style"].each (file, i) ->
      content = data.files[file]?.content
      editor = editors[i]
      editor.reset(content)

    rerender()

update = ->
  if id = location.hash?.substring(1)
    Gistquire.update id, postData(), (data) ->

$ ->
  window.editors = [
    ["data", "coffee"]
    ["template", "haml"]
    ["style", "stylus"]
  ].map ([id, mode]) ->
    $el = $("##{id}")

    editor = TextEditor
      mode: mode
      el: $el.get(0) # Dislike having to pass in an element here
      text: $el.text()

    editor.text.observe rerender

    return editor

  Gistquire.onload()

  if id = location.hash?.substring(1)
    load(id)
  else
    rerender()

  $("#actions .save").on "click", save
  $("#actions .auth").on "click", Gistquire.auth
  $("#actions .update").on "click", update
