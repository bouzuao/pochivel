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
    str = "%02d" % i.to_s
     pref = 'pref=' + str + '0000'
    hotel_api = 'http://jws.jalan.net/APIAdvance/StockSearch/V1/?key=aqr1442b809a0e&'
    pp hotel_api += pref
    pp hotel_api += '&stay_count=2&adult_num=2&count=50'
    apis << hotel_api
    end

    apis.each do |url|
      h = Hash.from_xml(open(url).read)
      h['Results']['Plan'].each do |t|
        pp t['PlanPictureURL']
        pp t['PlanPictureURL']
    #    #pp t['mood'][0]['photo']
    #    #content= Content. new
    #    #content.image_url =  t['mood'][0]['photo']
    #    #content.url = t['urls']['pc']
    #    #content.genre = 4
    #    #content.save
      end
    end

  end
end

