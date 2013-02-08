class @Collection extends Backbone.Collection
  initialize: (items, options) ->
    @options          = options
    @_fetchedDeferred = $.Deferred()
    super items

  # @see fetched
  fetch: (options = {}) ->
    userDefinedSuccess = options.success
    options.success = (a,b,c) =>
      @_fetchedDeferred.resolve()
      userDefinedSuccess? a,b,c

    super options

  fetched: (callback) ->
    @_fetchedDeferred.done callback