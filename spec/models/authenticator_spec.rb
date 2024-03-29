require 'spec_helper'
require_relative '../model_spec_helper'

describe Authenticator do
  include SpecHelpers

  let(:user) { double("User").as_null_object }
  let(:all_users) {
    um = double("User fetcher").as_null_object
    um.stub(:find_or_create_by_email).and_return(user)
    um
  }

  let(:store) { double("SessionStore Protocol").as_null_object }

  subject{
    Authenticator.new(store, auth_hash, all_users)
  }

  it "accepts a 'auth info' and a 'session store' on constructor" do
    lambda { Authenticator.new([], []) }.should_not raise_error
  end

  it "recover values from session store" do
    store.should_receive(:"[]").with(:xpto)
    subject.current :xpto
  end

  describe "produces authentication object" do
    let(:finder) {
      f = double("auth finder").as_null_object
      f.stub(:find_or_create_by_uid).and_return(Authentication.new(uid:auth_hash["uid"]))
      f
    }

    it "creates authentication with correct uid" do
      finder.should_receive(:find_or_create_by_uid).with(auth_hash["uid"])
      subject.new_authentication_with_info(auth_hash, finder)
    end

    it "stores raw_info on authentication" do
      new_auth = subject.new_authentication_with_info(auth_hash, finder)
      new_auth.data.should == auth_hash["info"].merge(auth_hash["extra"])
    end

  end

  context "#authenticate with valid auth info" do

    def authenticate
      subject.authenticate
    end

    it "find user based on email" do
      all_users.should_receive(:find_or_create_by_email).with(auth_hash["info"]["email"])
      authenticate
    end

    it "updates user authentications" do
      user.should_receive(:add_authentication)
      authenticate
    end

    it "uses session store to save a user" do
      store.should_receive(:"[]=").with(:user, {id: user.id})
      authenticate
    end

    it "updates the user information" do
      all_users.should_receive(:add_or_update).with(user)
      authenticate
    end

  end# authenticate with valid auth_info

end
