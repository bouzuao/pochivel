class Answer < ActiveRecord::Base
  belongs_to :user

  def question
    Question.find(self.question_id)
  end
end
