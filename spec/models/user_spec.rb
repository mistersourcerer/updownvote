require 'spec_helper'

describe User do

  it "forbids direct access to authentication relation reader" do
    expect {
      subject.authentications << Authentication.new
    }.to_not change{ subject.authentications.count }.by(1)
  end

  it "forbids direct access to authentication relation writer" do
    ->{ subject.authentications = [] }.should raise_error
  end

  it "associates authentication with current user" do
    auth = Authentication.new user:nil
    auth.should_receive(:user=).with(subject)
    subject.add_authentication(auth)
  end

  context "existing authentication" do
    let(:auth_with_data) { Authentication.new uid: "123", data:{ borba: "teste" } }

    before do
      @auth = Authentication.new uid: "123", data:{}
      subject.add_authentication @auth
    end

    it "don't add authentication if it already exists" do
      expect {
        subject.add_authentication @auth
      }.to_not change { subject.authentications.count }.by(1)
    end

    it "update auth info if it already exists" do
      subject.add_authentication auth_with_data
      @auth.data.should == auth_with_data.data
    end

  end
end
