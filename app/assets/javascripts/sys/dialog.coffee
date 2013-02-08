class @Dialog extends View
  className: "modal"
  path: "dialog"

  initialize: ->
    super

    
    @render()

    @currentScreen = null
    @screens = []
    @newScreen()

    $("body").append @$el
    @addCloseButton("Close")
    @setTitle @options.title if @options.title
    @show()

    @on "new.screen", (event) =>
      log 'hey', event
      event.data @newScreen()


  addButton: (options, callback) ->
    @currentScreen.addButton options, callback


  addCloseButton: (text) ->
    @currentScreen.addCloseButton text
    # @addButton {text, type: "pull-left"}, =>
    #   @close()

  close: ->
    @trigger "close"
    @hide =>
      @remove()

  addBody: (view) ->
    @currentScreen.append view


  setTitle: (title) ->
    @currentScreen.setTitle title 
    # @activateScreen()

  addHead: (view) ->
    @currentScreen.header.append view



  newScreen: () ->
    @addScreen new ScreenView
    @currentScreen
    

  addScreen: (screen) ->
    _.invoke @screens, "hide"

    screen.dialog  = @
    @currentScreen = screen
    @screens.push @currentScreen
    # @find('.modal-header').append @currentScreen.header.$el
    # @find('.modal-body').append @currentScreen.$el
    # @find(".modal-footer").append @currentScreen.controls.$el

    @append @currentScreen.header, ".modal-header"
    @append @currentScreen, '.modal-body'
    @append @currentScreen.controls, ".modal-footer"

    _.defer => @activateScreen screen

    @currentScreen.on "remove", =>
      index = @screens.indexOf @currentScreen
      if index > -1
        @screens.splice index, 1

      @currentScreen = @screens[@screens.length - 1]
      @activateScreen @currentScreen
      # @screens[@screens.length - 1].show()
    @

  activateScreen: (screen) ->
    screen = @currentScreen unless screen
    screen.show()

    log.info screen.header.subViews(), "<<<<<"

    unless screen.header.subViews().length
      @hideHeader()
    else
      @showHeader()

    unless screen.controls.subViews().length
      @hideFooter()
    else
      @showFooter()

  show: ->    

  hide: (callback) ->
    @$el.addClass "fade"
    _.delay @$el.removeClass, 300, "fade"
    _.delay callback, 300

  hideFooter: (callback) ->
    @find(".modal-footer").hide()

  hideHeader: (callback) ->
    @find(".modal-header").hide()

  showFooter: (callback) ->
    @find(".modal-footer").show()

  showHeader: (callback) ->
    @find(".modal-header").show()

class ScreenView extends View
  initialize: ->
    super
    @controls = new View
    @header   = new View
    @dialog   = @options.dialog

  addButton: ({type, text}, callback) ->
    btn = (new Button {type, text, callback}).render()

    @controls.append btn
    @dialog?.activateScreen()
    btn

  setTitle: (title) ->
    # @header.empty()
    view = (new View tagName: "h3", partial: title).render()
    @addToHeader view
    # @header.append view
    # @dialog?.activateScreen()

  addToHeader: (view) ->
    @header.append view
    @dialog?.activateScreen()


  remove: ->
    @controls.remove()
    @header.remove()
    super


  addCloseButton: (text = "Close") ->
    @addButton {
      text
      type: "pull-left"
    }, => @dialog.close()

  addDestroyButton: (text = "Back") ->
    @addButton {
      text
      type: "pull-left"
    }, => @remove()

  hide: ->
    super
    @controls.hide()
    @header.hide()

  show: ->
    super
    @controls.show()
    @header.show()





class Button extends View
  tagName   : "button"
  className : "btn"

  events: 
    "click": "click"

  initialize: ->
    super

    @$el.addClass @options.type

  click: (event) ->
    event.preventDefault()
    log @options
    @options.callback?()

    @trigger "click"

  connectTo: (view) ->
    @on "click", ->
      view.trigger "button.click"

    view.on "view.disable", => @disable()
    view.on "view.enable", => @enable()
    @

  enable: ->
    @$el.removeAttr("disabled")

  disable: ->
    @$el.attr("disabled", "disabled")


  partial: ->
    """
      #{@options.text}
    """

