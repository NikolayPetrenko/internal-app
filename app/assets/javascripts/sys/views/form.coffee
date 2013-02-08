class @FormView extends View
  tagName: "form"
  events: 
    "submit": "_submit"

  initialize: ->
    super
    @_errors = []
    @on "button.click", => @submit()

  disable: ->
    @trigger 'view.disable'

  enable: ->
    @trigger 'view.enable'

  data: ->
    @$el.formParams()

  _submit: (event) ->
    event.preventDefault()
    @submit()

  submit: (event) ->
    log.warn "override submit method of the form class", @data()

  errors: (errors) ->
    _.invoke @_errors, "remove"
    
    @_errors =  for error in errors
      @append  (error = new Error text: error).render(), ".errors-container"
      error

    

class Error extends View
  partial: ->
    """
      <div class="alert">
        #{@options.text}
      </div>
    """



