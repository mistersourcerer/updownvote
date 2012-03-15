require 'spec_helper'
require_relative '../model_spec_helper'

describe SessionsController do
  include SpecHelpers

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = auth_hash
  end

  context "#create" do

    describe "Authenticator configuration" do
      before do
        @omg_lol = Authenticator
        Authenticator = double("Authenticator").as_null_object
        Authenticator.stub(:new).and_return{
          double("authenticator instance").as_null_object
        }
      end

      after do
        Authenticator = @omg_lol
      end

      it "creates an authenticator" do
        Authenticator.should_receive(:new).with(any_args)
        get :create
      end

      it "passes the session to authenticator" do
        Authenticator.should_receive(:new).with(session, request.env["omniauth.auth"])
        get :create
      end

    end# #create

    it "redirect to root if fail to authenticate user" do
      get :create
      response.should redirect_to root_path
    end

    it "redirect to projects if succeed on authentication" do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
      get :create
      response.should redirect_to projects_path
    end

  end

end
