class @NewTestDialog extends Dialog
  afterRender: ->
    @addBody (form = new NewTestForm @options).render()
    @addButton({text: "Create", type: "btn-success"}).connectTo form
    form.on "done", (model) =>
      @close()
