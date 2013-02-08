class @AbstractListView extends View
  path              : "list"
  containerSelector : ".bb-items-container:first"

  initialize: () ->
    super

    @items     = []

    collection = @options.collection
    if collection
      @setCollection collection

    # @enableEvents()
    
  setCollection: (collection) ->
    # _.invoke @getViewItems(), "remove"
    
    @collection = collection
    @options.collection = collection

    collection.on "add", (newItem) =>
      @add newItem, (@options.appendMethod or "prepend")

    collection.on "remove", (model) =>
      for viewItem in @getViewItems()
        viewItem.remove() if viewItem.model is model

    collection.on "reset", =>
      @redraw()
      
      

  redraw: ->
    log "---------invoking redraw"
    _.invoke @getViewItems(), "remove"
    @drawItems()

  drawItems: ->
    @collection.forEach (item) => @add item

  connectTo: (view) ->
    view.on "search", (search) =>
      @collection.search search


  getViewItems: ->
    _.extend [], @items
  
  # reset: ->
  #   _.invoke @getViewItems(), "remove"



  add: (newInstanceModel, addMethod = "append") ->
    itemView = new (@itemConstructor(newInstanceModel)) model: newInstanceModel
    # console.log itemView, newInstanceModel, "!!!!!!!!!!!<<<"
    @items.push itemView
    @[addMethod] itemView, @containerSelector
    itemView.render()
    # newInstanceModel.once "remove", -> itemView.remove()

    itemView.on "remove", =>
      index = @items.indexOf itemView

      @items.splice index, 1 if index > -1

    itemView


  itemConstructor: (instanceModel) ->
    AbstractListItemView

  # enableEvents: ->
  #   # log 'enableEvents', @
  #   @collection.enableEvents (unsubscriber) => # unsubscribe from events when we done
  #     @on "remove", -> unsubscriber()

  render: ->
    super

    if @collection
      @drawItems()

    @


class @AbstractListItemView extends View
  path: "list-item"