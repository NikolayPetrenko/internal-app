class @ScheduleDialog extends Dialog
  afterRender: ->
    @setTitle "Schedule: #{@options.test.get("title")}"

    @addBody (form = new ScheduleForm @options).render()
    createButton = @addButton {text: "Schedule", type: "btn-success"}
    createButton.connectTo form

    form.on "item.selected", (event) =>
      groups = event.view.model.collection # groups collection
      count  = groups.where(selected: yes).length
      if count
        createButton.enable()
      else
        createButton.disable()
