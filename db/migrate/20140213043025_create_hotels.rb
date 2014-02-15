class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :planname
      t.string :Roomname
      t.string :plandetailurl
      t.string :Facility
      t.string :plancheckin
      t.string :plancheckOut
      t.string :splyperiodstrday
      t.string :splyperiodEndday
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

      t.string :Hotelname
      t.string :PostCode
      t.string :HotelAddress
      t.string :Region
      t.string :Prefecture
      t.string :LargeArea
      t.string :SmallArea
      t.string :HotelType
      t.string :Hoteldetailurl
      t.string :HotelCatchCopy
      t.string :Hotelcaption
      t.string :pictureurl
      t.string :picturecaption
      t.string :X
      t.string :Y
      t.string :HotelnameKana
      t.string :NumberOfRatings
      t.string :Rating
      t.timestamps
    end
  end
end
