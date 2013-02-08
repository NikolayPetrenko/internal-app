class @TestsControlPanel extends View
  path: "pages/tests/control-panel"

  events:
    "click .bb-click-create-new": "newTest"

  newTest: (event) ->
    event.preventDefault()

    dialog = new NewTestDialog @options