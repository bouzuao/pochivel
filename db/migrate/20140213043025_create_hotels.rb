class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :url
      t.text :image_url
      #t.text :title

      t.timestamps
    end
  end
end
