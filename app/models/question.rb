class Question < ActiveRecord::Base
  belongs_to :workout
  has_many :answers, :dependent => :destroy
  
  attr_accessible :body, :random_answers, :answer_type

  validates :body, :presence => true, :length => {:minimum => 2}
  validates :answer_type, :inclusion  => {:in => %w(radio checkbox), :message => "%{value} is not valid"} 

  def Question.create(workout, questionHash, answers)
    validItems = answers.reject do |item| 
      item[:is_valid].to_i == 0
    end

    savedAnswers = []
    question = nil

    transaction do 
      question = workout.questions.new questionHash
      if validItems.count == 0
        question.errors.add :question, "must have at least one valid answer"
      else
        question.save
        # logger.debug question.errors.inspect

        logger.debug "answers.count.inspect"
        logger.debug answers.count.inspect
        answers.each do |answerHash|
          logger.debug "------------------------------------"
          answer = {:body => answerHash[:body], :is_valid => answerHash[:is_valid]}

          answer = question.answers.new answer
          unless answer.save
            answer.errors.each { |key, value| question.errors.add "answer #{key}", value }

            raise ActiveRecord::Rollback, "Cant save answer"
          end

          savedAnswers.push answer
        end
      end

    end

    {:question => question, :answers => savedAnswers}
  end

  def Question.update(question_id, questionHash, answers)
    validItems = answers.reject do |item| 
      item[:is_valid].to_i == 0
    end

    question = Question.find question_id
    question.update_attributes questionHash


    updatedAnswers = []
    answers.each do |answerHash|
      answer = answerHash[:id] ? Answer.find(answerHash[:id]) : question.answers.new({:body => answerHash[:body], :is_valid => answerHash[:is_valid]})
      answer.save
      updatedAnswers.push answer

    end

    question.answers = updatedAnswers

    question
  end
end
