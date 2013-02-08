class @MainContainerView extends View
  setPage: (page) ->
    @empty()
    @append page
    page.render()

