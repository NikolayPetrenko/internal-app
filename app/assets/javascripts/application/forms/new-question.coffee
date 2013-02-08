class @NewQuestionForm extends FormView
  path: "forms/new-question"

  events: 
    "change select.bb-change-type": "changeType"
    # "blur .bb-change-body:first": "_setBody"
    "click .bb-click-expand:first": "expandEditor"

  initialize: ->
    super

    @initModel()
    @bindEvents()

  initModel: ->
    if @options.question
      model = @options.question
    else
      model = new QuestionModel {}, test: @options.test
      model.answers  = new AnswersCollection 
      model.answers.add()
      model.answers.add()

    @model = model

    

    @options.model         = model
    @model = model

    @model.on "change:answer_type", =>
      log 'invoking set', @model.get("answer_type")
      @model.answers.invoke "set", answer_type: @model.get("answer_type")

  newModel: ->
    @options.question = null
    @initModel()

  _setBody: () ->
    body = @find('.bb-change-body:first').val()
    log 'set body', body
    @model.set {body}

  expandEditor: (e) ->
    e.preventDefault()
    @fire 'expand.editor', @editor


  bindEvents: ->
    @on "make.valid", (event) =>
      {model, checked} = event.data
      if @model.get("answer_type") is "radio"
        @model.answers.invoke "set", is_valid: 0

      model.set is_valid: if checked then 1 else 0

    @on 'expand.editor', (event) =>
      
      editor = event.data

      @fire 'new.screen', (screen) =>
        @toolbar = new EditorToolbarView

        @toolbar.on "image.click", (view) =>
          @fullEditor.editor.currentView.element.focus()
          @fullEditor.editor.composer.commands.exec "insertImage", src: view.model.get("attachment").url

        screen.addToHeader @toolbar.render()

        @fullEditor = new FullEditorView text: editor.getValue()
        @fullEditor.render()

        @fullEditor.on "collapse", =>
          editor.setValue @fullEditor.getValue()
          editor.fire 'change'

          screen.remove()

        screen.append @fullEditor

      


  newQuestion: ->
    @newModel()
    @render()

  submit: ->
    final = =>
      @enable()

    @disable()
    
    # collection =  @model.collection or @options.test.questions
    options = {
      success: =>
        final()
        unless @model.collection
          @options.test.questions.add @model

        @newQuestion()
      error: (errors) =>
        @errors errors
        final()
    }

    @model.save {}, options


    # if @model.collection
    #   @model.collection.create @model, options
    # else
    #   @model.save {}, options



    # @model.save {},
    #   success: =>
    #     @options.test.questions.add @model
    #     @reset()
    #     final()
    #   error: (errors) =>
    #     @errors errors
    #     final()

  addAnswer: ->
    log @
    @model.answers.add {hello: "world"}

  afterRender: ->
    @editor = new wysihtml5.Editor "wysihtml5-textarea", 
      parserRules:  wysihtml5ParserRules 
      stylesheets: ["/assets/wysiwyg.css"]

    @editor.on 'change', => @_setBody()


    @append (answersList = new AnswersListView collection: @model.answers), ".bb-answers-container"
    answersList.render()

  changeType: ->
    value = @find("select.bb-change-type").val()
    log 'setting type', value
    @model.set answer_type: value

  # reset: ->
  #   @model.answers.add()
  #   @model.answers.add()

class FullEditorView extends View
  path: "forms/new-question-full-editor"

  events: 
    "click .bb-click-collapse": "collapse"

  getValue: ->
    @editor.getValue()

  setValue: (value) ->
    @editor.setValue value

  collapse: (e) -> 
    e.preventDefault()
    @trigger "collapse"

  afterRender: ->
    @editor = new wysihtml5.Editor "wysihtml5-textarea-full", 
      toolbar:      "wysihtml5-toolbar-full"
      parserRules:  wysihtml5ParserRules 
      stylesheets: ["/assets/wysiwyg.css"]

    @setValue @options.text

    
    

class EditorToolbarView extends View
  path: "forms/new-question-editor-toolbar"

  events: 
    "click .bb-click-show-images": "showImages"

  showImages: ->
    log "hello there"

    @fire 'new.screen', (screen) =>
      screen.addDestroyButton("Back")
      screen.setTitle "Images"
      screen.append imagesList = new AttachmentsListView collection: App.storage.images
      imagesList.render()
      screen.append (form = new ImagesForm).render()
      input = form.find ".bb-file-input"
      form.hide()
      # dropZone = form.find ".bb-drop-zone"
      @setupUploader input

      imagesList.on "image.click", (event) => 
        # log event, "<<<<<"
        view = event.view
        @trigger "image.click", view
        screen.remove()

  setupUploader: (input, dropZone) ->
    input.fileupload
      dataType  : 'json'
      paramName : "attachment[attachment]"
      dropZone  : dropZone
      url: "/attachments"
      # dragover: (e, data) ->
      #   log.info e, data
      add: (e, data) =>
        log.debug e, data, "<<<<<<<"
        data.submit()

      submit: (e, data) ->
        log 'submit ---', e, data

      progress: (e, data) ->
        # log.debug e, data, "progress"
        progress = parseInt(data.loaded / data.total * 100, 10)
        log.info progress, "_______======"

      done: (e, data) ->
        App.storage.images.add data.result
        log "))))))))))))))))", e, data.result




class ImagesForm extends View
  partial: ->
    """
      <input type="file" class="bb-file-input" />
    """