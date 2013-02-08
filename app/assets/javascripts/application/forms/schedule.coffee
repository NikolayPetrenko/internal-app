class @ScheduleForm extends FormView
  path: "forms/schedule"

  afterRender: ->
    @append (@list = new ScheduleGroupsListView collection: App.storage.groups).render()


class ScheduleGroupsListView extends AbstractSelectableListView
  path              : no
  tagName           : "ul"
  containerSelector : no
  className         : "thumbnails"
  onlyOne           : yes
  
  itemConstructor   : -> ScheduleGroupsListItemView

class ScheduleGroupsListItemView extends AbstractSelectableListItemView
  tagName : "li"
  className : "span4 thumbnail"
  path    : "forms/schedule/group-item-view"

  

