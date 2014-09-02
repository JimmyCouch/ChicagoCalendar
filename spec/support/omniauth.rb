def set_omniauth(opts = {})
  default = {:provider => :facebook,
             :uuid     => "1234",
             :facebook => {
                            :email => "foobar@example.com",
                            :gender => "Male",
                            :first_name => "foo",
                            :last_name => "bar"
                          }
            }

  credentials = default.merge(opts)
  provider = credentials[:provider]
  user_hash = credentials[provider]

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
    :provider => provider,
    :uid => credentials[:uuid],
    :info => {
      :email => user_hash[:email],
      :name => user_hash[:first_name]
    }
  })
end

def set_invalid_omniauth(opts = {})

  credentials = { :provider => :facebook,
                  :invalid  => :invalid_crendentials
                 }.merge(opts)

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]

end