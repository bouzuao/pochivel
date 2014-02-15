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
      #stay_date = 'stay_date=' + Date.today.strftime("%Y%m%d")
      hotel_api = 'http://jws.jalan.net/APIAdvance/StockSearch/V1/?key=aqr1442b809a0e&'
      hotel_api += pref
      hotel_api += '&stay_count=2&adult_num=2&min_rate=10000&max_rate=50000&count=100'
      pp apis << hotel_api
    end

    apis.each do |api|
      pp h = Hash.from_xml(open(api).read)
      if h['Results']['Plan'].present?
        h['Results']['Plan'].each do |t|
          if t['PlanPictureURL'].present?
            hotel= Hotel.new
            hotel.planname = t['PlanName']
            hotel.roomname = t['RoomName']
            hotel.plandetailurl = t['PlanDetailURL']
            hotel.plancheckin = t['PlanCheckIn']
            hotel.plancheckOut = t['PlanCheckOut']
            hotel.splyperiodstrday  = t['SplyPeriodStrDay']
            hotel.splyperiodendday  = t['SplyPeriodStrDay']
            hotel.planpictureurl = t['PlanPictureURL']
            hotel.planpicturecaption  = t['PlanPictureCaption']
            hotel.meal  = t['Meal']
            hotel.ratetype  = t['RateType']
            hotel.samplerate = t['SampleRate']
            hotel.servicechargerate  = t['ServiceChargeRate']
            #pp hotel.date   = t['Stay']['Date']['date']
            #pp hotel.month   = t['Stay']['Date']['month']
            #pp hotel.year   = t['Stay']['Date']['year']
            #pp hotel.rate   = t['Stay']['Rate']
            hotel.hotelid  = t['Hotel']['HotelID']
            hotel.hotelname = t['Hotel']['HotelName']
            hotel.postcode    = t['Hotel']['PostCode']
            hotel.hoteladdress = t['Hotel']['HotelAddress']
            hotel.region  = t['Hotel']['Area']['Region']
            hotel.prefecture  = t['Hotel']['Area']['Prefecture']
            hotel.largearea   = t['Hotel']['Area']['LargeArea']
            hotel.smallarea    = t['Hotel']['Area']['SmallArea']
            hotel.hoteltype   = t['Hotel']['HotelType']
            hotel.hoteldetailurl   = t['Hotel']['HotelDetailURL']
            hotel.hotelcatchcopy   = t['Hotel']['HotelCatchCopy']
            hotel.hotelcaption    = t['Hotel']['HotelCaption']
            hotel.pictureurl         = t['Hotel']['PictureURL']
            hotel.picturecaption     = t['Hotel']['PictureCaption']
            hotel.x                  = t['Hotel']['X']
            hotel.y                   = t['Hotel']['Y']
            hotel.hotelnamekana       = t['Hotel']['HotelNameKana']
            hotel.numberofratings     = t['Hotel']['NumberOfRatings']
            hotel.rating    = t['Hotel']['NumberOfRatings']
            hotel.save
          end
        end

      end
    end

  end
  def self.execute_test
    #TODO:主要サイトの洗い出しとそれに合わせての検索結果をどうするかを決める。
    #TODO:テーブルにどこまでデータを保持するかを検討する必要がある。。
    #TODO:ある程度のサイトは一つのモジュールで対応可能なためパラメータや条件で取得を変えるようにしたい。

    areas = []
    apis = []
    h = Hash.from_xml(open('http://www.jalan.net/jalan/doc/jws/data/area.xml').read)
    h['Area']['Prefecture'].each do |pref|
      pref['LargeArea'].each do |area|
        areas << area['cd']
      end
    end

    areas.each do |area_id|
      l_area = 'l_area=' + area_id
      stay_date = 'stay_date=' + Date.today.strftime("%Y%m%d")
      hotel_api = 'http://jws.jalan.net/APIAdvance/StockSearch/V1/?key=aqr1442b809a0e&'
      hotel_api += l_area
      hotel_api += '&stay_count=2&adult_num=2&min_rate=10000&max_rate=50000&count=100&'
      hotel_api += stay_date
      pp apis << hotel_api
    end
    #apis.each do |api|
    #  h = Hash.from_xml(open(api).read)
    # if h['Results']['Plan'].present?
    #    h['Results']['Plan'].each do |t|
    #      if t['PlanPictureURL'].present?
    #        hotel = Hotel.new
    #        hotel.planname = t['PlanName']
    #        hotel.roomname = t['RoomName']
    #        hotel.plandetailurl = t['PlanDetailURL']
    #        hotel.plancheckin = t['PlanCheckIn']
    #        hotel.plancheckOut = t['PlanCheckOut']
    #        hotel.splyperiodstrday  = t['SplyPeriodStrDay']
    #        hotel.splyperiodendday  = t['SplyPeriodStrDay']
    #        hotel.planpictureurl = t['PlanPictureURL']
    #        hotel.planpicturecaption  = t['PlanPictureCaption']
    #        hotel.meal  = t['Meal']
    #        hotel.ratetype  = t['RateType']
    #        hotel.samplerate = t['SampleRate']
    #        hotel.servicechargerate  = t['ServiceChargeRate']
    #        hotel.date   = t['Stay']['Date'].first['date'].to_s
    #        hotel.month   = t['Stay']['Date'].first['month'].to_s
    #        hotel.year   = t['Stay']['Date'].first['year'].to_s
    #        hotel.rate   = t['Stay']['Date'].first['Rate'].to_s
    #        hotel.stock   = t['Stay']['Date'].first['Stock'].to_s
    #        hotel.hotelid  = t['Hotel']['HotelID']
    #        hotel.hotelname = t['Hotel']['HotelName']
    #        hotel.postcode    = t['Hotel']['PostCode']
    #        hotel.hoteladdress = t['Hotel']['HotelAddress']
    #        hotel.region  = t['Hotel']['Area']['Region']
    #        hotel.prefecture  = t['Hotel']['Area']['Prefecture']
    #        hotel.largearea   = t['Hotel']['Area']['LargeArea']
    #        hotel.smallarea    = t['Hotel']['Area']['SmallArea']
    #        hotel.hoteltype   = t['Hotel']['HotelType']
    #        hotel.hoteldetailurl   = t['Hotel']['HotelDetailURL']
    #        hotel.hotelcatchcopy   = t['Hotel']['HotelCatchCopy']
    #        hotel.hotelcaption    = t['Hotel']['HotelCaption']
    #        hotel.pictureurl         = t['Hotel']['PictureURL']
    #        hotel.picturecaption     = t['Hotel']['PictureCaption']
    #        hotel.x                  = t['Hotel']['X']
    #        hotel.y                   = t['Hotel']['Y']
    #        hotel.hotelnamekana       = t['Hotel']['HotelNameKana']
    #        hotel.numberofratings     = t['Hotel']['NumberOfRatings']
    #        hotel.rating    = t['Hotel']['NumberOfRatings']
    #        hotel.save
    #      end
    #
    #    end
    #
    #
    #  end
    #
    #end
  end

end
