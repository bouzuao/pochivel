require 'active_support'
require "open-uri"
require "rubygems"
require "nokogiri"
require 'nkf'
require 'pp'

# -*- encoding: utf-8 -*-


#検索結果ではURL単一しか取れないから
#Aowsomeなどを利用して単一の検索結果に対して
#複数のURLを取得しそのURLの画像とタイトルを取得する。

class Tasks::InsertContentsTask
  def self.execute_api
    #TODO:主要サイトの洗い出しとそれに合わせての検索結果をどうするかを決める。
    #TODO:テーブルにどこまでデータを保持するかを検討する必要がある。。
    #TODO:ある程度のサイトは一つのモジュールで対応可能なためパラメータや条件で取得を変えるようにしたい。

    apis = []
    for i in 1..47 do
      #for i in 1..2 do
      str = "%02d" % i.to_s
      pref = 'pref=' + str + '0000'
      stay_date = 'stay_date' + Date.today.strftime("%Y%m%d")
      hotel_api = 'http://jws.jalan.net/APIAdvance/StockSearch/V1/?key=aqr1442b809a0e&'
      hotel_api += pref
      hotel_api += '&stay_count=2&adult_num=2&min_rate=10000&max_rate=50000&count=100&'
      hotel_api +=  stay_date
      pp apis << hotel_api
    end

    apis.each do |api|
      h = Hash.from_xml(open(api).read)
      if h['Results']['Plan'].present?
        h['Results']['Plan'].each do |t|
          if t['PlanPictureURL'].present?
            hotel= Hotel.new
            pp hotel.planname = t['PlanName']
            pp hotel.roomname = t['RoomName']
            pp hotel.plandetailurl = t['PlanDetailURL']
            pp hotel.plancheckin = t['PlanCheckIn']
            pp hotel.plancheckOut = t['PlanCheckOut']
            pp hotel.splyperiodstrday  = t['SplyPeriodStrDay']
            pp hotel.splyperiodendday  = t['SplyPeriodStrDay']
            pp hotel.planpictureurl = t['PlanPictureURL']
            pp hotel.planpicturecaption  = t['PlanPictureCaption']
            pp hotel.meal  = t['Meal']
            pp hotel.ratetype  = t['RateType']
            pp hotel.samplerate = t['SampleRate']
            pp hotel.servicechargerate  = t['ServiceChargeRate']
            pp hotel.servicechargerate  = t['Stay']
            pp hotel.date   = t['Date']
            pp hotel.month   = t['month']
            pp hotel.year   = t['year']
            pp hotel.rate   = t['Rate']
            pp hotel.hotelid  = t['Hotel']['HotelID']
            pp hotel.hotelname = t['Hotel']['HotelName']
            pp hotel.postcode    = t['Hotel']['PostCode']
            pp hotel.hoteladdress = t['Hotel']['HotelAddress']
            pp hotel.region  = t['Hotel']['Area']['Region']
            pp hotel.prefecture  = t['Hotel']['Area']['Prefecture']
            pp hotel.largearea   = t['Hotel']['Area']['LargeArea']
            pp hotel.smallarea    = t['Hotel']['Area']['SmallArea']
            pp hotel.hoteltype   = t['Hotel']['HotelType']
            pp hotel.hoteldetailurl   = t['Hotel']['HotelDetailURL']
            pp hotel.hotelcatchcopy   = t['Hotel']['HotelCatchCopy']
            pp hotel.hotelcaption    = t['Hotel']['HotelCaption']
            pp hotel.pictureurl         = t['Hotel']['PictureURL']
            pp hotel.picturecaption     = t['Hotel']['PictureCaption']
            pp hotel.x                  = t['Hotel']['X']
            pp hotel.y                   = t['Hotel']['Y']
            pp hotel.hotelnamekana       = t['Hotel']['HotelNameKana']
            pp hotel.numberofratings     = t['Hotel']['NumberOfRatings']
            pp hotel.rating    = t['Hotel']['NumberOfRatings']
            pp hotel.save
          end
        end

      end
    end

  end
end

