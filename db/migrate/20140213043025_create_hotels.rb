class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :planname
      t.string :roomname
      t.string :plandetailurl
      t.string :facility
      t.string :plancheckin
      t.string :plancheckOut
      t.string :splyperiodstrday
      t.string :splyperiodendday
      t.string :planpictureurl
      t.string :planpicturecaption
      t.string :meal
      t.string :ratetype
      t.string :samplerate
      t.string :servicechargerate
      t.string :stay
      t.string :date
      t.string :month
      t.string :year
      t.string :rate
      t.string :stock
      t.string :hotelid
      t.string :hotelname
      t.string :postcode
      t.string :hoteladdress
      t.string :region
      t.string :prefecture
      t.string :largearea
      t.string :smallarea
      t.string :hoteltype
      t.string :hoteldetailurl
      t.string :hotelcatchcopy
      t.string :hotelcaption
      t.string :pictureurl
      t.string :picturecaption
      t.string :x
      t.string :y
      t.string :hotelnamekana
      t.string :numberofratings
      t.string :rating
      t.timestamps
    end
  end
end
