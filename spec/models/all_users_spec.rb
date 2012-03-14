describe AllUsers do

  subject { AllUsers.new(double("User").as_null_object) }

  it { should respond_to :find_or_initialize_by_email }

end
