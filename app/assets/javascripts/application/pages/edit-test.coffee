class @EditTestPageView extends View
  render: ->
    super

    tests = App.storage.tests
    tests.fetched =>

      @test = test = App.storage.tests.get @options.id

      @append (new EditTestControlPanel {test}).render()
      @appendQuestionList()

      test.questions.fetch()
      log test.questions

  appendQuestionList: ->
    list = new QuestionsListView collection: @test.questions
    @append list.render()