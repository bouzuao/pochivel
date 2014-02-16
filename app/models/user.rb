class User < ActiveRecord::Base
  has_many :answers

  # 最大質問回数
  def max_questions
    9
  end

  # 同時最大選択肢数
  def max_choices
    4
  end

  # すでに選択した条件のids
  # [1, 2, 5]
  def decide_conditions
    (1..max_questions).map do |i|
      self.send("cond_#{i}")
    end.compact
  end

  # まだ選ばれていない条件のids
  # [3, 4, 6, 7, 8, 9]
  def yet_conditions
    Condition.all.map(&:id) - decide_conditions
  end

  # 次の質問集
  # return [<onsen>, ...]
  def get_next_conditions!
    next_ids = yet_conditions.shuffle.take(4)

    next_ids.each.with_index(1) do |next_id, i|
      self.send("last_cond_#{i}=".to_sym, next_id)
    end

    self.save

    next_ids.map{|next_id| Condition.find(next_id)}
  end

  def last_id_to_conditon_id(int)
    self.send("last_cond_#{int}")
  end

  # API通信用オブジェクト作成
  # {reg: '01', onsen: true, ...}
  def generate_condition_for_request
    hash = {}
    hash[:reg] = select_region.code if self.reg_id

    (1..max_questions).each do |i|
      cond_id = self.send("cond_#{i}")
      next if cond_id.nil?

      hash[Condition.find(cond_id).parameter.to_sym] = true
    end

    hash
  end

  # userが質問を完了しているか判定
  def finish_question?
    if self.select_region
      api_request = ApiRequest.generate(self.generate_condition_for_request)
      api_request.total_count < 1000
    else
      # regionが指定されていない時はfinishにしない
      false
    end
  end

  # 選択された地方
  def select_region
    Region.find(self.reg_id) if self.reg_id
  end

  # 検索された条件
  def select_conditions
    (1..max_questions).map do |i|
      cond_id = self.send("cond_#{i}")
      next if cond_id.nil?

      Condition.find(cond_id)
    end.compact
  end

  # 検索条件のなかで一番おすすめのもの
  def best_hotel
    api_request = ApiRequest.generate(self.generate_condition_for_request)
    api_request.best_hotel
  end
end
