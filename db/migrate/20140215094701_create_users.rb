class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :tel

      t.integer :number
      t.integer :date
      t.integer :span

      t.integer :reg_id

      t.integer :cond_1
      t.integer :cond_2
      t.integer :cond_3
      t.integer :cond_4
      t.integer :cond_5
      t.integer :cond_6
      t.integer :cond_7
      t.integer :cond_8
      t.integer :cond_9

      t.integer :last_cond_1
      t.integer :last_cond_2
      t.integer :last_cond_3
      t.integer :last_cond_4

      t.timestamps
    end
  end
end
