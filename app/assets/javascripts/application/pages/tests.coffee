class @TestsPageView extends View
  render: ->
    super

    testsList = App.storage.tests

    @append (new TestsControlPanel collection: testsList).render()
    @append (listView = new TestsListView collection: testsList).render()
    log listView

    # testsList.fetch()
