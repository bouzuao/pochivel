class ApiRequest < ActiveRecord::Base

  # API通信して同じURLをキャッシュ
  # condition {Hash} {reg: '01', onsen: true, ...}
  def self.generate(condition)
    instance = self.new

    puts 'ApiRequest.fetch'
    p condition
    p url = self.end_point(condition)

    # レスポンスキャッシュ
    saved_request = self.where(url: url).first
    if saved_request.present?
      saved_request
    else
      instance.url = url
      instance.response = open(instance.url).read
      instance.save

      instance
    end
  end

  # API用URLを組み立て
  def self.end_point(condition)
    url = "http://jws.jalan.net/APIAdvance/StockSearch/V1/?key=#{Settings.jalan_api_key}&count=10&"

    condition.each do |k, v|
      if k == :reg
        url += "reg=#{v}&"
      else
        url += "#{k}=1&"
      end
    end

    url
  end

  # parse後のdoc
  def xml
    @_xml ||= Nokogiri::XML(self.response)
  end

  # この条件のHit数
  def total_count
    xml.css('Results NumberOfResults').text.to_i
  end

  def best_hotel
    @_best_hotel ||= xml.css('Results Hotel').first
  end
end
