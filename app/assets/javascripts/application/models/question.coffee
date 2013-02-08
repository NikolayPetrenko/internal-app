class @QuestionModel extends Model
  urlRoot: ->
    log @, "<<<<"
    id = if @options.test
      @options.test.get('id')
    else
      @get("workout_id")

    if id
      "/workouts/#{id}/questions"

  defaults:
    answer_type : "radio"
    body        : ""

  initialize: () ->
    super

    unless @answers
      @answers = new AnswersCollection [], question: @

  parse:(data) ->
    answers = data.answers
    delete data.answers
    @answers = new AnswersCollection answers, question: @
    super data

  toJSON: ->
    question = super
    question.answers = @answers.toJSON()

    question

  save: (attrs, options) ->
    question         = @toJSON()
    answers          = (answer.toJSON() for answer in @answers.models)
    question.answers = answers

    url = if @get("id") then  @urlRoot() + "/" + @get('id') else @urlRoot()
    method = if @get("id") then "put" else "post"

    $.ajax
      url  : url
      type : method
      data : question
      success: (result, success) =>
        answers = result.answers
        delete result.answers

        @set result
        @answers.reset answers
        options.success? @, options
      error: (response, type, okay) ->
        return unless okay is "OK"

        errors = $.parseJSON response.responseText
        options.error? errors
    


    