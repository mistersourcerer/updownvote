describe AllUsers do

  let(:user_finder) { double("User finder").as_null_object }
  let(:user_store) { double("User store").as_null_object }
  let(:user) { double("User").as_null_object }

  subject { AllUsers.new(user_finder) }

  it { should respond_to :find_or_initialize_by_email }

  it "uses a store to save an user instance" do
    all = AllUsers.new(user_finder, user_store)
    user_store.should_receive(:save)
    all.add_or_update(user)
  end

  it "proxies the #save call to the parameter if dosen't exists a store" do
    user.should_receive(:save)
    subject.add_or_update(user)
  end

end
