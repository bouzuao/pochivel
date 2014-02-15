class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :url
      t.text :image_url
      t.string :prefecture
      t.string :samplerate
      t.string :plan_name
      t.timestamps
    end
  end
end
