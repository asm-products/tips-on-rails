require 'rails_helper'

describe Tip do

  let(:user) { FactoryGirl.create(:user) }
  before { @tip = user.tips.build(description: "Lorem ipsum") }

  subject { @tip }

  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  
  

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @tip.user_id = nil }
  	it { should_not be_valid }
  end

  describe "with blank content" do
    before { @tip.description = " "}
    it { should_not be_valid }
end

  describe "with content that is too long" do
    before { @tip.description = "a" * 141 }
    it { should_not be_valid }
  end
end
