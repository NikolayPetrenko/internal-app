class @TestsListView extends AbstractListView
  tagName           : "ul"
  containerSelector : ""
  path              : ""

  itemConstructor   : -> TestsListItemView

class TestsListItemView extends AbstractListItemView
  tagName : "li"
  path    : "lists/test-item-view"

  events:
    "click .bb-click-remove": "destroy"
    "click .bb-click-schedule" : "schedule"
    # "click .bb-click-edit": "edit"

  destroy: (event) ->
    event.preventDefault()
    @model.destroy()

  schedule: (event) ->
    event.preventDefault()

    new ScheduleDialog test: @model