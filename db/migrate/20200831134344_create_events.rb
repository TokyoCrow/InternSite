class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.belongs_to :user 
      t.string :title,					null: false, default: ''
      t.text :discription,				null: false, default: ''
      t.date :date,						null: false, default: '2000-01-01'
      t.integer :weekday,				null: false, default: 1
      t.boolean :repeat_every_day,		null: false, default: false
      t.boolean :repeat_every_week,		null: false, default: false
      t.boolean :repeat_every_month,	null: false, default: false
      t.boolean :repeat_every_year,		null: false, default: false
      t.timestamps
    end
  end
end
