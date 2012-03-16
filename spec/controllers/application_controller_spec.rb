require "spec_helper"

describe ApplicationController do

  context "::uses_authenticator" do

    it "adds an instance method called auth" do
      class << @controller
        uses_authenticator :omg_lol
      end

      @controller.should respond_to :omg_lol
    end

    it "defaults the method name to auth" do
      class << @controller
        uses_authenticator
      end

      @controller.should respond_to :auth
    end

    it "the generated methods returns an object that is_a? Authenticator" do
      class << @controller
        uses_authenticator
      end

      @controller.auth.should be_a Authenticator
    end

  end# ::users_authenticator

  context "::uses_current_user" do
    before do
      class << @controller
        uses_current_user
      end
    end

    it "adds an instance method #current_user" do
      @controller.should respond_to :current_user
    end

    it "returns the object in session related to the :user key" do
      user = double("User")
      session[:user] = user
      @controller.current_user.should be(user)
    end
  end

end
