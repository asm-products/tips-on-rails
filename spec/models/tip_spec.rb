require 'rails_helper'

describe Tip do

  let(:user) { FactoryGirl.build_stubbed(:user) }
  let(:tip) { FactoryGirl.build_stubbed(:tip) }

  subject { tip }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:body) }
  it { should respond_to(:user_id) }
  it { should respond_to(:slug) }
  it { should respond_to(:user) }
  
  describe 'when all validations are satisfied' do
    it { should be_valid }
  end

  describe "associations" do
    it { should belong_to(:user).counter_cache(true) }
    it { should have_many(:bookmarks).dependent(:destroy) }
  end

  describe 'validations' do
    it { should_not allow_value(' ').for(:title) }
    it { should_not allow_value(' ').for(:description) }
    it { should_not allow_value(' ').for(:body) }
    it { should validate_length_of(:title).is_at_most(50) }
    it { should validate_length_of(:description).is_at_most(250) }
  end

  describe "before save" do
    it "should pygmentize_and_cache_body" do
      expect(tip).to receive(:pygmentize_and_cache_body)
      tip.save! 
    end
  end

  describe "#title_and_username" do    
    context "method creates string that" do
      it "should be equal" do
        user = User.all
        user.each do |user|
          expect(tip.title_and_username).to eq("#{tip.title} by #{user.username}")
        end
      end
    end
  end

  describe "#bookmarked_by" do
    context "for user with no bookmarks" do
      it "should be false" do
        expect(tip.bookmarked_by(user)).to be_falsy
      end
    end
  end

  describe "#pygmentize_and_cache_body" do
    it "should render the tip body" do
      expect(tip.pygmentize_and_cache_body).to eq("<p>#{tip.body}</p>\n")
    end
  end

  describe "#should_generate_friendly_id?" do
    let(:user) { User.create(first_name: "Example", last_name: "User", email: "newuser@example.com", 
                              username: "example") }
    
    context "tip is persisted" do
      it "should be true if tip isn't a new record or been destroyed" do
        tip_is = user.tips.create(title: "Tips", body: "other tip", description: "tips here", created_at: 1.hour.ago)
        expect(tip_is.persisted?).to be_truthy
      end
    end

    context "tip is persisted" do
      it "should be false if tip is a new record" do
        tip = user.tips.build(title: "Tips", body: "other tip", description: "tips here")
        expect(tip.persisted?).to be_falsy
      end
    end

    context "has existed for greater than a day" do
      it "should be false" do
        persisted_tip_cant_change = user.tips.create(title: "Tips", body: "other tip", description: "tips here", created_at: 2.days.ago)
        expect(persisted_tip_cant_change.should_generate_new_friendly_id?).to be_falsy
      end
    end

    context "has existed less than a day ago" do
      it "should be true" do
        persisted_tip_slug_can_change = user.tips.create(title: "Tips", body: "other tip", description: "tips here", created_at: Time.now)
        expect(persisted_tip_slug_can_change.should_generate_new_friendly_id?).to be_truthy
      end
    end

    context "tip doesn't exist in the database yet" do
      it "should be true" do
        not_persisted_tip = user.tips.create(title: "Tips", body: "other tip", description: "tips here")        
        expect(not_persisted_tip.should_generate_new_friendly_id?).to be_truthy
      end
    end
  end
           
  describe "#title_must_be_unique_for_user" do
    context "when slug doesn't exist" do
      it "tip slug shouldn't equal another tips slug" do  
        expect(tip.title_must_be_unique_for_user).to_not eq("this-by-mofucker")
      end
    end

    context "when slug exists" do
      it "tip slug should equal another tips slug" do
        expect(tip.title_must_be_unique_for_user).to eq(tip.title_must_be_unique_for_user)
      end
      
      it "adds correct error message" do
        tip = Tip.all
        tip.each do |tip|
          expect(tip.errors[:title]).to eq("already exists. Please change it")
          expect(tip.errors[:title].size).to be > 1
        end
      end       
    end 
  end

  describe "Order of tips" do
    before do
      FactoryGirl.create(:tip, title: 'Older tip title', created_at: 1.day.ago, user: user)
      FactoryGirl.create(:tip, title: 'Newer tip title', created_at: 1.hour.ago, user: user)
    end

    it 'should have the newer_tip first and older_tip second' do
      expect(user.tips.map(&:title)).to eq(['Newer tip title', 'Older tip title'])
    end
  end
end
