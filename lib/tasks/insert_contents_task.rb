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

    apis = ['http://jws.jalan.net/APIAdvance/StockSearch/V1/?key=aqr1442b809a0e&pref=010000&stay_count=3&adult_num=2&count=50']
    apis.each do |url|
      h = Hash.from_xml(open(url).read)

      h['Results']['Plan'].each do |t|
        pp t
        #pp t['urls']['pc']
        #pp t['mood'][0]['photo']
        #content= Content. new
        #content.image_url =  t['mood'][0]['photo']
        #content.url = t['urls']['pc']
        #content.genre = 4
        #content.save

      end
    end

  end
end

