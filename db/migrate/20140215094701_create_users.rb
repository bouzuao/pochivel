class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :tel
      t.integer :number
      t.integer :date
      t.integer :span

      t.timestamps
    end
  end
end
