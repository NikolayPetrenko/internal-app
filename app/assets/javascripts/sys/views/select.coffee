class SelectView extends AbstractListView
  add: (model) ->
    @$el.append @itemHtml(model)

  itemHtml: (model) ->
    log.warn "Override SelectView::itemHtml"
