class @EditTestControlPanel extends View
  path: "pages/edit-test/control-panel"

  events:
    "click .bb-click-create-new": "newQuestion"

  newQuestion: (event) ->
    event.preventDefault()

    dialog = new NewQuestionDialog @options