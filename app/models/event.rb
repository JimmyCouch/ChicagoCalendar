class Event < ActiveRecord::Base
	has_and_belongs_to_many :users
	validates :title, uniqueness: true
	validates :datetime, presence: true
end
