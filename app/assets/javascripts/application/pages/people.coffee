class @PeoplePageView extends View
  afterRender: ->
    @append (controlPanel = new PeopleControlPanel).render()
    @append (new PeopleManagePanel {controlPanel}).render()