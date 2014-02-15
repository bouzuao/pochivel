class Question < ActiveYaml::Base
  set_root_path Rails.root.join('app/models').to_s

  # @params num {Integer} choice number
  def find_choice(num)
    self.send("choice_#{num}".to_sym)
  end

end
