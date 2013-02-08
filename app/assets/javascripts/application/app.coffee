class Application
  constructor: ->
    $ =>
      @initStorage()
      @mainContainer = new MainContainerView el: $(".application-container")
      @navigationBar = new NavigationBarView el: $(".bb-navbar")
      @run()

  run: ->
    log 'running'
    @router = router = AppRouter.start()

    
  setPage: (page) ->
    @mainContainer.setPage page

  initStorage: ->
    @storage =
      tests: (tests = new TestsCollection)
      images: (attachments = new AttachmentsCollection)
      groups: (groups = new GroupsCollection)

    tests.fetch()
    attachments.fetch()
    groups.fetch()





window.App = new Application