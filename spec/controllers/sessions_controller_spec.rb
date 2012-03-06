require 'spec_helper'

describe SessionsController do

  before do
    OmniAuth.config.mock_auth[:github] = {
      :provider => 'github',
      :uid => '123545',
      :extra => {:raw_info => {
        :email => email
      }}
    }

    class AllUsers
      def with_email(_email)
        return user if _email == email
      end
    end
  end

  let(:email) do "github@test" end
  let(:user) do u = User.new :email => email end

  describe "success authentication" do

    before do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    end

    it "store user on the session" do
      post :create
      session[:user].should == user
    end
  end
end
