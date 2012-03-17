require "spec_helper"

describe ApplicationController do

  context "access control methods" do

    it "allow access to the authenticator" do
      @controller.should respond_to :auth
    end

    it "#auth returns an object that is_a? Authenticator" do
      @controller.send(:auth).should be_a(Authenticator)
    end

    it "allow access to logged in user via #current_user" do
      @controller.should respond_to :current_user
    end

    it "#current_user returns the object in session related to the :user key" do
      user = double("User")
      session[:user] = user
      @controller.send(:current_user).should be(user)
    end

  end# access control

end

module MySpec

  class RestrictedController < ApplicationController
    protect_from_unauthorized :except => [:omglol]

    def xpto
      render :text => "x"
    end

    def omglol
      render :text => "LoL"
    end
  end

  describe RestrictedController do

    context "access control (ordinary controllers)" do

      it "#redirect_to :index if none authorized user is present" do
        get :xpto
        response.should redirect_to root_path
      end

      it "lives the action alone if an authorized user exists" do
        session[:user] = "borba"
        get :xpto
        response.should_not redirect_to root_path
      end

      it "leave the action alone if we say so" do
        get :omglol
        response.should be_success
      end

    end

  end# authorization control

end
