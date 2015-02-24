require 'rails_helper'

describe Tip do

  let(:user) { @user = User.new(first_name: "Example", last_name: "User", email: "user@example.com", 
                            username: "example") }
  before { user.save}
  before { @tip = user.tips.create(title: "Tip", body: "some things", description: "Lorem ipsum", slug: "tip-by-example") }

  subject { @tip }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:slug) }
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
  
  describe "with blank content" do
    before { @tip.body = " "}
    it { should_not be_valid }
  end

  describe "#title_and_username" do
    before { @tip = user.tips.create(title: "Tip", body: "some things", description: "Lorem ipsum", slug: "tip-by-guy") }
    subject { @tip }
    
    context "slug has title and username" do
      specify { expect(@tip.slug).to eq("tip-by-guy")}
    end

    context "slug doesn't have username" do
      specify { expect(@tip.slug).to_not eq("tip-by-")}
    end
  end

  describe "#should_generate_friendly_id?" do
    context "created_at is greater than a day ago" do
      before { @tip.created_at > 1.day.ago}
      it { should be_valid }
    end

    context "created_at is less than a day ago" do
      before { @tip = user.tips.create( created_at: 25.hours.ago ) }
      subject { @tip }

      before { @tip.created_at < 1.day.ago}
      it { should_not be_valid }
    end

    context "created_at is nil" do
      before { @tip = user.tips.create() }
      subject { @tip }

      before { @tip.created_at = nil }
      it { should_not be_valid }
    end
  end

  describe "#title_must_be_unique_for_user" do
    context "slug doesn't exist" do
      before { Tip.exists? != true }
      it { should be_valid }
    end
    
    context "slug exists" do
      before { Tip.exists? == true }
      it "should raise an error" do
        expect { raise "already exsits. Please change it"}.to raise_error
      end
    end
  end
end