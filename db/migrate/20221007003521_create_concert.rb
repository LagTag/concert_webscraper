class CreateConcert < ActiveRecord::Migration[7.0]
  def change
    create_table :concerts do |t|
      t.string :url
      t.belongs_to :venue
      t.datetime :start_time
      t.timestamps
    end
  end
end
