class User < ActiveRecord::Base
  has_many :answers

  def finish_calling?
    self.answers.count == 3
  end

end
