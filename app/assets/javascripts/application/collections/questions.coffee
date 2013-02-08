class @QuestionsCollection extends Collection
  url: ->
    "/workouts/#{@options.test.get('id')}/questions"

  model: QuestionModel

class @AnswersCollection extends Collection
  model: AnswerModel