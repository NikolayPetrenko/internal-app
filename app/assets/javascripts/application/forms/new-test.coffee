class @NewTestForm extends FormView
  path: "forms/new-test"

  submit: ->
    log "submit the form", @data()

    final = =>
      @enable()

    @disable()
    # model = new @collection.model @data()
    # model.save {}, 
    @collection.create @data(),
      wait: yes
      success: (model) =>
        @trigger "done", model
        @collection.add model
        final()
      error: (model, response, errors) =>
        @errors $.parseJSON response.responseText
        final()