describe AllAuthentications do

  subject { AllAuthentications.new(double("Authentication").as_null_object) }

  it { should respond_to :find_or_initialize_by_uid }

end
