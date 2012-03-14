require 'spec_helper'
require_relative '../model_spec_helper'

describe Authenticator do
  include SpecHelpers

  let(:user) { double("User").as_null_object }
  let(:all_users) {
    um = double("User fetcher").as_null_object
    um.stub(:find_or_initialize_by_email).and_return(user)
    um
  }

  let(:authentication) { double("Authentication").as_null_object }
  let(:all_auths) {
    am = double("Authentication fetcher").as_null_object
    am.stub(:find_or_initialize_by_uid).and_return(authentication)
    am
  }

  subject{ Authenticator.new(auth_hash, store, all_auths, all_users) }

  let(:store) { double("SessionStore Protocol").as_null_object }

  it "accepts a 'auth info' and a 'session store' on constructor" do
    lambda { Authenticator.new([], []) }.should_not raise_error
  end

  it "recover values from session store" do
    store.should_receive(:"[]").with(:xpto)
    subject.current :xpto
  end

  context "#authenticate with valid auth info" do

    def authenticate
      subject.authenticate
    end

    it "find authentication based on uid" do
      all_auths.should_receive(:find_or_initialize_by_uid).with(auth_hash["uid"])
      authenticate
    end

    it "find user based on email" do
      all_users.should_receive(:find_or_initialize_by_email).with(auth_hash["info"]["email"])
      authenticate
    end

    it "associates authentication with user" do
      user.should_receive(:add_authentication).with(authentication)
      authenticate
    end

    it "uses session store to save a user" do
      store.should_receive(:"[]=").with(:user, user)
      authenticate
    end

  end# authenticate with valid auth_info

end
