class CallWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(tel)
    client = Twilio::REST::Client.new Settings.twilio.account_sid, Settings.twilio.auth_token

    client.account.calls.create(
      :from => Settings.twilio.caller_id,     # 発信者
      :to => tel, # 電話先
      :url => "#{Settings.twilio.app_host}/twiml/start" # twxml
    )
  end
end
