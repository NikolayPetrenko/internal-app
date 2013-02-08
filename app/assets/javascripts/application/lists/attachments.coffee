class @AttachmentsListView extends AbstractListView
  tagName           : "ul"
  className         : "thumbnails"
  containerSelector : ""
  path              : ""

  itemConstructor   : -> AttachmentsListItemView

class AttachmentsListItemView extends AbstractListItemView
  tagName   : "li"
  path      : "lists/attachment-item-view"
  className : "image-holder"

  # events: 
  #   "click a": "click"

  propagate:
    "click a": "image.click"

  # capture:
  #   "image.click": "click"

  # click: ->
  #   log 'hello there'

  # click: (e) ->
  #   e.preventDefault()
  #   @fire "image.click", @