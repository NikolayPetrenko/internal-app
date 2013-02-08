class @UsersListView extends AbstractSelectableListView
  className         : "thumbnails"
  path              : "lists/user-list-view"

  itemConstructor   : -> UserListItemView

  initialize: ->
    super

    @collection.on "change:selected", =>
      itemsCount = @collection.where(selected: yes).length
      @find(".bb-update-selected").html "#{itemsCount} selected"

class UserListItemView extends AbstractSelectableListItemView
  tagName   : "li"
  className : "span4 thumbnail"
  
  path      : "lists/user-item-view"
