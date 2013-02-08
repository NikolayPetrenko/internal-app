class @GroupsListView extends AbstractListView
  path              : "lists/groups-container"
  events: 
    "click .bb-click-new-group": "newGroup"

  newGroup: (e) ->
    e.preventDefault()
    title = "Group " + (@collection.length + 1)
    @collection.create {title}

  itemConstructor   : -> GroupListItemView

class GroupListItemView extends AbstractListItemView
  tagName : "li"
  path    : "lists/group-item-view"

  events:
    "click .bb-click-drop": "drop"

  propagate:
    "click .bb-click-add stopPropagation": "people.add"
    "click": "change.collection"

  drop: (e) ->
    e.preventDefault()
    @model.destroy()

