class @AnswersListView extends AbstractListView
  tagName           : "ul"
  containerSelector : ""
  path              : ""

  itemConstructor   : -> AnswerListItemView

class AnswerListItemView extends AbstractListItemView
  tagName : "li"
  path    : "lists/answer-item-view"

  events:
    "click .bb-click-remove"      : "destroy"
    "change .bb-click-make-valid" : "_makeValid"
    # "change .bb-change-body:first"      : "_setBody"
    "click .bb-click-expand:first": "expand"
    # "click .bb-click-edit": "edit"

  destroy: (event) ->
    event.preventDefault()
    @model.collection.remove @model

  _setBody: (event) ->
    log @model, "<<<<<"
    body = @editor.getValue()
    @model.set {body}

  initialize: ->
    super

    @model.on "change:answer_type", => 
      log 'rendering type info'
      @render()

    @model.on "change:valid", => 
      log 'rendering valid info'
      @render()

  _makeValid: (event) ->
    target  = $(event.currentTarget)
    checked = target.is ":checked"
    @fire "make.valid", {@model, checked}

  expand: (e) ->
    e.preventDefault()
    @fire "expand.editor", @editor

  afterRender: ->
    log '-----------------------------------------------------------', "answer-item-" + @model.cid, document.getElementById("answer-item-" + @model.cid)
    log @$el.find("textarea")[0]


    @editor = new wysihtml5.Editor @$el.find("textarea")[0], 
      parserRules:  wysihtml5ParserRules 
      stylesheets: ["/assets/wysiwyg.css"]

    @editor.on 'change', => 
      log 'updating'
      @_setBody()

