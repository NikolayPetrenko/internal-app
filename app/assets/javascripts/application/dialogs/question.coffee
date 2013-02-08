class @NewQuestionDialog extends Dialog
  afterRender: ->
    @setTitle "New Question"

    @addBody (form = new NewQuestionForm @options).render()
    answerButton = @addButton {text: "Add answer"}

    text = if @options.question then "Update" else "Create"
    createButton = @addButton {text, type: "btn-success"}
    answerButton.on "click", -> form.addAnswer()
    createButton.connectTo form
