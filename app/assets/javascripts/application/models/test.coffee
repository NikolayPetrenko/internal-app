class @TestModel extends Model
  # url: -> "/workouts/#{@get('id')}"
  parse: (data) ->
    @questions = new QuestionsCollection [], test: @
    super data
    
    