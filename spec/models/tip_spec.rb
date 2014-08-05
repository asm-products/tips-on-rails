require 'rails_helper'

describe Tip do

  let(:user) { FactoryGirl.create(:user) }
  before { @tip = user.tips.build(title: "Tip", description: "Lorem ipsum") }

  subject { @tip }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:body) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  
  it { should be_valid }

  describe "when user_id is not present" do
  	before { @tip.user_id = nil }
  	it { should_not be_valid }
  end

  describe "with blank title" do
    before { @tip.title = " "}
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @tip.title = "a" * 51 }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @tip.description = " "}
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @tip.description = "a" * 251 }
    it { should_not be_valid }
  end
end
