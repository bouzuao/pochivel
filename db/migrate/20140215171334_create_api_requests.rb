class CreateApiRequests < ActiveRecord::Migration
  def change
    create_table :api_requests do |t|
      t.string :url
      t.text :response

      t.timestamps
    end
  end
end
