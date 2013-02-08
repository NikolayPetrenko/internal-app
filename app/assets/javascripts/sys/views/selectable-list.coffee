class @AbstractSelectableListView extends AbstractListView
  add: ->
    itemView = super

    if @options.onlyOne or @onlyOne
      itemView.on "item.selected", (event) =>
        @collection.each (model) ->
          if model isnt event.view.model
            model.set selected: no



    itemView

  itemConstructor: -> AbstractSelectableListItemView

  selectedItems: (models = yes) ->
    @collection.where selected: yes


class @AbstractSelectableListItemView extends AbstractListItemView
  events: 
    "click": "toggle"

  initialize: ->
    super

    @model.on "change:selected", =>
      @reflectState()

  reflectState: ->
    if @model.get('selected')
      @addClass "active"
    else
      @removeClass "active"

  toggle: ->
    if @model.get("selected")
      @model.set selected: no
    else
      @model.set selected: yes

    @fire "item.selected"



  