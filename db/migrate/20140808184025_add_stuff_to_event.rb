class AddStuffToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :title, :string
  	add_column :events, :desc, :string
  	add_column :events, :url, :string
  	add_column :events, :datetime, :datetime
  end
end
