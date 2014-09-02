describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

end

describe User, '.from_omniauth' do
	before(:each) do 
		@user_hash = set_omniauth()
		@user = User.from_omniauth(@user_hash)
	end

	it "User should be defined" do
		expect(@user).not_to be_nil
	end

	it "#email is returned" do
		expect(@user.email).to match(/#{@user_hash.email}/)
	end

	it "#uid is returned" do
		expect(@user.uid).to match(/#{@user_hash.uid}/)
	end
	it "#name is returned" do
		expect(@user.name).to match(/#{@user_hash.name}/)
	end
end
 