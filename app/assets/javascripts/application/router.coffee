class @AppRouter extends Backbone.Router
  routes: 
    tests  : "tests"
    people : "people"
    "tests/:id"     : "editTest"
    

  tests: () ->
    @_load TestsPageView

  editTest: (id) ->
    @_load EditTestPageView, {id}

  people: ->
    @_load PeoplePageView

  

  _load: (pageConstructor, params = {}) ->
    page = new pageConstructor params
    App.setPage page

  mainPage: ->
    @navigate "main", trigger: yes

  @start: ->
    router = new AppRouter
    unless Backbone.history.start({pushState: no})
      router.navigate "tests", trigger: yes
    router