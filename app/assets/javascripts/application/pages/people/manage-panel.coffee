class @PeopleManagePanel extends View
  path: "pages/people/manage-panel"

  afterRender: ->
    users = new UsersSearchCollection
    users.fetch()

    window.test = users

    @append (usersListView = new UsersListView collection: users).render(), ".content"
    @append (groupsListView = new GroupsListView collection: App.storage.groups).render(), ".content"

    usersListView.connectTo @options.controlPanel

    groupsListView.on "change.collection", (event) ->
      usersCollection = event.view.model.users()
      usersCollection.fetch()
      usersListView.setCollection usersCollection

    @options.controlPanel.on "change.collection", =>
      usersListView.setCollection users
      @options.controlPanel.search()

    groupsListView.on "people.add", (event) ->
      groupModel     = event.view.model
      selectedPeople = usersListView.collection.where selected: yes
      groupModel.add selectedPeople










