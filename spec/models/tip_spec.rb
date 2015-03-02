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

  describe "before save" do
    it "should pygmentize_and_cache_body" do
      expect(tip).to receive(:pygmentize_and_cache_body)
      tip.save! 
    end
  end

  describe "with blank title" do
    before { tip.title = " "}
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { tip.title = "a" * 51 }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { tip.description = " "}
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { tip.description = "a" * 251 }
    it { should_not be_valid }
  end
  
  describe "with blank content" do
    before { tip.body = " "}
    it { should_not be_valid }
  end

  describe "#title_and_username" do 
    context "has title and username" do
      it "should be equal" do
        user = User.all
        user.each do |user|
          expect(tip.title_and_username).to eq("#{tip.title} by #{user.username}")
        end
      end
    end
  end

  describe "#bookmarked_by" do

  end

  describe "#pygmentize_and_cache_body" do
    it "should render the tip body" do
      expect(MarkDownRenderer.new.pygmentize_and_render(tip.body)).to eq("<p>#{tip.body}</p>\n")
    end
  end

  describe "#should_generate_friendly_id?" do
    let(:user) { User.create(first_name: "Example", last_name: "User", email: "newuser@example.com", 
                              username: "example") }

    context "tip is persisted and has existed for greater than a day" do
      it "should be false" do
        persisted_tip_can_change = user.tips.build(title: "Tips", body: "other tip", description: "tips here", created_at: 2.days.ago)
        
        if persisted_tip_can_change.created_at > 1.day.ago
          expect(persisted_tip_can_change.should_generate_new_friendly_id?).to be_falsy
        end
      end
    end

    context "tip is persisted, but less than a day ago" do
      it "should be true" do
        persisted_tip_slug_cant_change = user.tips.build(title: "Tips", body: "other tip", description: "tips here", created_at: Time.now)
        
        if persisted_tip_slug_cant_change.created_at > 1.day.ago
          expect(persisted_tip_slug_cant_change.should_generate_new_friendly_id?).to be_truthy
        end
      end
    end

    context "doesn't exist in the database yet" do
      it "should be true" do
        not_persisted_tip = user.tips.build(title: "Tips", body: "other tip", description: "tips here")        
        expect(not_persisted_tip.should_generate_new_friendly_id?).to be_truthy
      end
    end
  end
           
  describe "#title_must_be_unique_for_user" do
    context "slug doesn't exist" do
      it "should be valid" do  
        @tip = Tip.all
        @tip.each do |tip|
          expect("this-by-mofucker").to_not eq(tip.slug)
        end
      end
    end

    context "slug exists" do
      it "should be invalid" do
        @tip = Tip.all
        @tip.each do |tip|
          expect(tip.slug).to eq(tip.slug)
        end
      end
      it "should raise an error" do
        tip = user.tips.create(slug: "tip-by-example")
        tip.valid?
        expect(tip.errors[:title].size).to be >= 1
      end
      it "adds correct error message" do
        @tip = user.tips.create()
        tip = Tip.all
        tip.each do |tip|
          if tip.slug == @tip.slug
            expect(tip.errors[:title]).to eq("already exists. Please change it")
          end
        end
      end       
    end 
  end

  describe "tips association" do
    before do
      FactoryGirl.create(:tip, title: 'Older tip title', created_at: 1.day.ago, user: user)
      FactoryGirl.create(:tip, title: 'Newer tip title', created_at: 1.hour.ago, user: user)
    end

    it 'should have the newer_tip first and older_tip second' do
      expect(user.tips.map(&:title)).to eq(['Newer tip title', 'Older tip title'])
    end
  end
end