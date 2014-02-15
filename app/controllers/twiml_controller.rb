class TwimlController < ApplicationController

  protect_from_forgery with: :null_session

  # Twilioの最初
  def start
    xml_str = Twilio::TwiML::Response.new do |response|
      response.Say "ポチベルをご利用いただきありがとうございます。 ", :language => "ja-jp"
      response.Redirect "#{Settings.twilio.app_host}/twiml/question?q_num=1&user_id=#{current_user.id}", method: 'POST'
    end.text

    render xml: xml_str
  end

  # Twilioの質問
  def question
    # 質問番号 0から始まる
    q_num = params[:q_num].to_i

    # 直前の回答
    last_answer = params[:Digits].presence.try(:to_i)

    # 回答を記録
    if last_answer
      current_user.answers.create({
        question_id: q_num - 1,
        choice: last_answer
      })
    end

    current_question = Question.where(id: q_num).first

    # 質問が終了する場合
    if current_question.blank?
      xml_str = Twilio::TwiML::Response.new do |response|
        response.Redirect "#{Settings.twilio.app_host}/twiml/finish?user_id=#{current_user.id}", method: 'POST'
      end.text

      render xml: xml_str
    else
      # TwiMLを作成
      xml_str = Twilio::TwiML::Response.new do |response|
        response.Gather timeout: 20, finishOnKey: '', numDigits: 1, action: "#{Settings.twilio.app_host}/twiml/question?q_num=#{q_num + 1}&user_id=#{current_user.id}" do |gather|

          # 直前の回答がある場合はそれを繰り返す
          if last_answer
            gather.Say "#{Question.find(q_num - 1).find_choice(last_answer)} ですね。 。 。", :language => "ja-jp"
          end

          # gather.Say "現在の検索条件でxxx件ヒットします。", :language => "ja-jp"

          gather.Say "#{current_question.contents}。   #{current_question.find_choice(1)} がいいかたは、 イチ を。   #{Question.find(q_num).find_choice(2)} がいいかたは、 ニ を  押してください", :language => "ja-jp"
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
