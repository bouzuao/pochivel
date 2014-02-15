class CreateApiCaches < ActiveRecord::Migration
  def change
    create_table :api_caches do |t|
      t.string :url
      t.text :response

      t.timestamps
    end
  end
end
