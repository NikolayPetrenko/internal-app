class @GroupModel extends Model
  initialize: ->
    super
    window.test = @

  add: (people) ->
    log ">>", people
    unless _.isArray people
      people = [people]

    for person in people
      @users().create {user_id: person.get('id')}

  users: ->
    unless @_usersCollection
      @_usersCollection = new GroupUsersCollection [], group: @

    @_usersCollection