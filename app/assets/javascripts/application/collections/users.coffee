class @UsersCollection extends Collection
  model : UserModel

class @UsersSearchCollection extends UsersCollection
  url   : "/users/search"

  search: (query) ->
    @fetch data: {query}
  

class @GroupUsersCollection extends UsersCollection
  url: ->
    "/groups/#{@options.group.get('id')}/groupusers"