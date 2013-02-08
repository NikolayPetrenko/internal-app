class @QuestionsListView extends AbstractListView
  path              : "lists/question-list-view"

  itemConstructor   : -> QuestionListItemView

  initialize: ->
    super

    @collection.on "reset add remove", =>
      @updateCount()

  updateCount: ->
    @find(".bb-total-items").html @collection.length + " questions"

class QuestionListItemView extends AbstractListItemView
  tagName: "li"
  path: "lists/question-item-view"

  events:
    "click .bb-click-remove"   : "destroy"
    "click .bb-click-edit"     : "edit"
    

  initialize: ->
    super

    @model.on "change", => @render()
    @model.answers.on "change", => @render()

  destroy: ->
    @model.destroy()

  edit: (event) ->
    event.preventDefault()
    new NewQuestionDialog question: @model

  
    




