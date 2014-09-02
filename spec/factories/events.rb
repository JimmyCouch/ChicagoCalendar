# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
  	id 1
  	title "Test title"
  	desc "heres a desc"
  	url "http://sampleurl.com"
  	datetime DateTime.now
  	address "200 W. Jackson st, Chicago Il"
  	lat "41.9233"
  	lng "-87.6753"
  end
end
