describe AllUsers do

  let(:user_finder) { double("User finder").as_null_object }
  let(:user_store) { double("User store").as_null_object }
  let(:user) { double("User").as_null_object }

  subject { AllUsers.new(user_finder) }

  it { should respond_to :find_or_create_by_email }

  it "proxies the #save call to the parameter if dosen't exists a store" do
    user.should_receive(:save)
    subject.add_or_update(user)
  end

end
