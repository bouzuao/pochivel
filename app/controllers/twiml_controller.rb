class TwimlController < ApplicationController

  protect_from_forgery with: :null_session

  # Twilioの最初
  def start
    xml_str = Twilio::TwiML::Response.new do |response|
      response.Say "ポチベルをご利用いただきありがとうございます。 ", :language => "ja-jp"
      response.Redirect "#{Settings.twilio.app_host}/twiml/question?q_num=0", method: 'POST'
    end.text

    render xml: xml_str
  end

  # Twilioの質問
  def question
    # 質問番号 0から始まる
    q_num = params[:q_num].to_i

    # 直前の回答
    last_answer = params[:Digits].presence

    # 質問が終了する場合
    if questions[q_num].blank?
      xml_str = Twilio::TwiML::Response.new do |response|
        response.Redirect "#{Settings.twilio.app_host}/twiml/finish", method: 'POST'
      end.text

      render xml: xml_str
    else
      # TwiMLを作成
      xml_str = Twilio::TwiML::Response.new do |response|
        response.Gather timeout: 20, finishOnKey: '', numDigits: 1, action: "#{Settings.twilio.app_host}/twiml/question?q_num=#{q_num + 1}" do |gather|

          # 直前の回答がある場合はそれを繰り返す
          if last_answer
            gather.Say "#{questions[q_num - 1][last_answer]} ですね。 。 。", :language => "ja-jp"
          end

          # gather.Say "現在の検索条件でxxx件ヒットします。", :language => "ja-jp"

          gather.Say "#{questions[q_num][:q]}。   #{questions[q_num][1]} がいいかたは  イチ を。   #{questions[q_num][2]} がいいかたは  ニ を  押してください", :language => "ja-jp"
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

  private

  def questions
    [
      {
        q: '旅行 の 行き先 を 決めてください',
        1 => '北のほう',
        2 => '南のほう'
      },
      {
        q: '旅館 か ホテル は どちらが いいですか',
        1 => '旅館',
        2 => 'ホテル'
      },
      {
        q: '海 と 山ならどちらがいいですか',
        1 => '海',
        2 => '山'
      }
    ]
  end
end
