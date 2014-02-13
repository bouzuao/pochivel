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

    apis = ['http://webservice.recruit.co.jp/relax/salon/v1?response_reserve=1&count=15&order=3&address=%E9%8A%80%E5%BA%A7&key=d80cc5011c92e61d',
            'http://webservice.recruit.co.jp/relax/salon/v1?response_reserve=1&count=15&order=3&address=%E6%B8%8B%E8%B0%B7&key=d80cc5011c92e61d'
    ]
    apis.each do |url|
      h = Hash.from_xml(open(url).read)

      h['results']['salon'].each do |t|
        pp t['urls']['pc']
        pp t['mood'][0]['photo']
        content= Content.new
        content.image_url =  t['mood'][0]['photo']
        content.url = t['urls']['pc']
        content.genre = 4
        content.save

      end
    end

  end
end

