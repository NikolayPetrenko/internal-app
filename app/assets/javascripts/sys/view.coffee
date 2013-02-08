class __dev extends Backbone.Model


window.dev = new __dev

class Tpl
  @get: (path) ->
    if JST[path] then JST[path] else false

window.jsonString  = (object) ->
  JSON.stringify plainObject $.extend(yes, {}, object)
  
window.plainObject = (object) ->
  if _.isObject object
    if "function" is typeof object.toJSON
      return object.toJSON()
    else
      for key, value of object
        object[key] = plainObject value
      object
  else if _.isArray object
    for value, key in object
      object[key] = plainObject value
    object
  else
    object


class @View extends Backbone.View
  @paths: [""]

  initialize: ->
    super

    @appendDestination = ""

    @__appendedViews = 
      list: []
      destinations: {}

    @_renderedDefer = $.Deferred()

    @_setCaptures()

    # some development things
    # dev.on "view.paths", =>
    #   return if @__pathLabelCreated

    #   view = $ @make "div", {class: "dev-label"}, @_viewPath() or ":::HTML MARKUP:::"
    #   @$el.append view
    #   @__pathLabelCreated = yes
    # end of development things

  find: (selector) ->
    @$el.find selector

  # show: ->
  #   @$el.show()

  # hide: ->
  #   @$el.hide()

  remove: ->
    super

    @trigger "remove"


  _viewPath: ->
    path = if @options.path then @options.path else @path

    path = if 'function' is typeof path
      path.call(@)
    else
      path

    return unless path

    for registeredPath in View.paths
      checkPath = registeredPath + path
      if JST[checkPath] 
        return checkPath
      # sysPath = "sys/templates/" + path
      # appPath = "application/templates/" + path
      # if JST[sysPath] then sysPath else appPath

  empty: ->
    @$el.empty()

  partial: ->
    if @options.partial
      @options.partial?() or @options.partial
    else
      no

  _render: (data) ->
    if viewPath = @_viewPath()
      renderFn = Tpl.get(@_viewPath())
      if renderFn
        _data = data or plainObject $.extend yes, {}, @options.model
        html  = renderFn _data
      else
        log.warn "template not found, rendering dummy"
        html = "Template NOT found, please check the path, or maybe you forgot to recompile views? <br /><b>path:::#{@_viewPath()}</b>"
    else if partial = @partial()
      html = partial
    else 
      log.warn "you didnt set any html partial for #{@constructor.name}"
      html = ""

    @$el.html html
    @_setPropagators()
    @trigger "afterRender"
    _.defer =>
      
    @_renderedDefer.resolve()
    @

  render: ->
    @_render()
    _.defer =>
      @afterRender()

    @

  _setPropagators: ->
    items = @propagate or {}

    for description, eventName of items
      [event, selector, method] = description.split " "
      jqueryObject      = if selector then @find(selector) else @$el

      do (jqueryObject, event, eventName, method) =>
        jqueryObject.bind event, (event) =>
          event.preventDefault()
          if method
            event[method]()
          @fire eventName, event

      # log "---", description, eventName
  
  _setCaptures: ->
    captures = @capture or {}

    for eventName, methodName of captures
      if @[methodName]
        @on eventName, (event) =>
          @[methodName] event 
      else
        log.warn "-".repeat(100)
        log.warn " ".repeat(20) + "WANTED TO CAPTURE #{eventName}"
        log.warn " ".repeat(20) + "THERE IS NO METHOD #{methodName} "
        log.warn " ".repeat(20) + "FOR CLASS #{@constructor.name} "
        log.warn " ".repeat(20) + "   have a nice day!"


  rendered: (callback) ->
    @_renderedDefer.done callback

  # addClass: (className) -> @$el.addClass className
  # removeClass: (className) -> @$el.removeClass className

  # @overridable
  afterRender: ->

  __add: (view, destination = "", fn = "append") ->
    destination or= @appendDestination
    @__appendedViews.list.push view

    if destination instanceof jQuery
      appendTo = destination
    else
      appendTo = if destination then @find(destination) else @$el

    appendTo[fn] view.$el
    view._parent = @

    view.on "remove", =>
      index = @__appendedViews.list.indexOf view
      if index > -1
        @__appendedViews.list.splice index, 1

    @

  # to be @deprecated
  # _bubbleEvent: (name, params) ->
  #   @trigger name, params
  #   @_parent?.bubbleEvent name, params

  # emmit an event
  fire: (name, params) ->
    bbEvent = new BBEvent @, params, name
    @_fireEvent bbEvent
    

  _fireEvent: (bbEvent) ->
    @trigger bbEvent.name, bbEvent

    unless bbEvent.isStopped()
      @_parent?._fireEvent bbEvent

  append:(view, destination = "") ->
    @__add view, destination

  prepend:(view, destination = "") ->
    @__add view, destination, "prepend"

  _clear: ->
    for view in @__appendedViews
      view.remove()

  html: (html) ->
    @_clear()
    @$el.html html

  subViews: ->
    $.extend [], @__appendedViews.list

_.extend View.prototype, Backbone.Events

class BBEvent 
  constructor: (view, data = {}, name) ->
    @name      = name
    @view      = view
    @data      = data
    # @prevented = no
    @stopped   = no

  isStopped: -> @stopped

  # isPrevented: -> @prevented

  stopPropagation: ->
    @stopped = yes

  # preventDefault: ->
  #   @prevented = yes

###
  proxy jQuery methods
###
_.each ["show", "hide", "addClass", "removeClass", "fadeIn", "fadeOut"], (method) ->
  View::[method] = (args...) ->

    @$el[method].apply @$el, args