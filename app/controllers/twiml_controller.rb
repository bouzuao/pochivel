class TwimlController < ApplicationController

  protect_from_forgery with: :null_session

  # Twilioの最初
  def start
    xml_str = Twilio::TwiML::Response.new do |response|
      response.Say " ポチ ベル をご利用いただき ありがとう ございます。 ", :language => "ja-jp"
      response.Redirect "#{Settings.app_host}/twiml/ask_region?user_id=#{current_user.id}", method: 'POST'
    end.text

    render xml: xml_str
  end

  # エリアを聞く
  def ask_region
    # TwiMLを作成
    xml_str = Twilio::TwiML::Response.new do |response|
      response.Gather timeout: 20, finishOnKey: '', numDigits: 1, action: "#{Settings.app_host}/twiml/question?q_num=1&user_id=#{current_user.id}" do |gather|
        gather.Say "旅行 の 行き先 を 決めてください", :language => "ja-jp"

        Region.all.each do |region|
          gather.Say "。 #{region.name} がいいかたは、 #{region.id} を", :language => "ja-jp"
        end

        gather.Say "押してください", :language => "ja-jp"
      end
    end.text

    render xml: xml_str
  end

  # Twilioの質問
  def question
    # 質問番号 0から始まる
    q_num = params[:q_num].to_i

    # 直前の回答
    last_answer = params[:Digits].presence.try(:to_i)

    # 直前の回答を保存
    # 直前がエリア絞り込みの場合
    if q_num == 1
      current_user.update_attributes({
        reg_id: last_answer
      })
    else
      current_user.update_attributes({
        "cond_#{q_num - 1}".to_sym => current_user.last_id_to_conditon_id(last_answer), # :cond_2 => 1
      })
    end

    current_4conditions = current_user.get_next_conditions!

    # 質問が終了する場合
    #   1. 次の絞り込みで件数が0になる
    #   2. 質問が終わる
    if false
      xml_str = Twilio::TwiML::Response.new do |response|
        response.Redirect "#{Settings.app_host}/twiml/finish?user_id=#{current_user.id}", method: 'POST'
      end.text

      render xml: xml_str
    else
      # TwiMLを作成
      xml_str = Twilio::TwiML::Response.new do |response|
        response.Gather timeout: 20, finishOnKey: '', numDigits: 1, action: "#{Settings.app_host}/twiml/question?q_num=#{q_num + 1}&user_id=#{current_user.id}" do |gather|

          # 直前の回答がある場合はそれを繰り返す
          # if last_answer
          #   gather.Say "#{Question.find(q_num - 1).find_choice(last_answer)} ですね。 。 。", :language => "ja-jp"
          # end

          gather.Say "次の 4つのなかから、ごだわりたい条件を一つ、選んでください。", :language => "ja-jp"

          current_4conditions.each.with_index(1) do |condition, i|
            gather.Say "#{condition.name}、がいいかたは、#{i} を", :language => "ja-jp"
          end
          gather.Say "押してください", :language => "ja-jp"
        end
      end.text

      render xml: xml_str
    end
  end

  # Twilioの最後
  def finish
    xml_str = Twilio::TwiML::Response.new do |response|
      response.Say "あなたの検索条件にヒットする 宿泊場所が見つかりました。 。 。", :language => "ja-jp"
      response.Say "電話を終了して、ブラウザに戻ってください。。", :language => "ja-jp"
    end.text

    render xml: xml_str
  end
end
