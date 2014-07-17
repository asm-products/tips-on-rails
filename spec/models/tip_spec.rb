require 'rails_helper'

describe Tip do

  before { @tip = user.tip.build(content: "Lorem ipsum") }

  subject { @tip }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @tip.user_id = nil }
  	it { should_not be_valid }
  end
end
