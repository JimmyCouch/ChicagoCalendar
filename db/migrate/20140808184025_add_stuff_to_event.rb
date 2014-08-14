class AddStuffToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :title, :string
  	add_column :events, :desc, :string
  	add_column :events, :url, :string
  	add_column :events, :date, :datetime
  	add_column :events, :time, :string
  	add_column :events, :month, :string
  	add_column :events, :year, :string

  end
end
