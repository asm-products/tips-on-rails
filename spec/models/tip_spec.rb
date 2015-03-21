require 'rails_helper'

describe Tip do

  let(:user) { build_stubbed(:user) }
  let(:tip) { build_stubbed(:tip) }

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

  describe 'associations' do
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

  describe 'before save' do
    it 'should pygmentize_and_cache_body' do
      expect(tip).to receive(:pygmentize_and_cache_body)
      tip.save! 
    end
  end

  describe '#title_and_username' do    
    context 'method creates string that' do
      it 'should be equal to "tip.title by user.username"' do
        expect(tip.title_and_username).to eq("#{tip.title} by #{user.username}")
      end
    end
  end

  describe '#bookmarked_by' do
    context 'for user with no bookmarks' do
      it 'should be false' do
        expect(tip.bookmarked_by(user)).to be_falsy
      end
    end

    context 'for user that bookmarked the tip' do
      it 'should be true' do
        another_user = build_stubbed(:user, email: 'another_user@example.com')
        another_user.bookmarks.create(tip: tip)
        expect(tip.bookmarked_by(another_user)).to be_truthy
      end
    end
  end

  describe '#pygmentize_and_cache_body' do
    it 'should render the tip body' do
      expect(tip.pygmentize_and_cache_body).to eq("<p>#{tip.body}</p>\n")
    end
  end

  describe '#should_generate_new_friendly_id?' do
    context 'when tip is brand new' do
      it 'should be true' do
        brand_new_tip = user.tips.build(attributes_for(:tip))
        expect(brand_new_tip.should_generate_new_friendly_id?).to be_truthy
      end
    end

    context 'when tip already exists' do
      it 'should be true if tip has been created less than 1 day ago' do
        new_tip = user.tips.create(attributes_for(:tip, created_at: 1.hour.ago))
        expect(new_tip.should_generate_new_friendly_id?).to be_truthy
      end
 
      it 'should be false if tip has been created more than 1 day ago' do
        old_tip = user.tips.create(attributes_for(:tip, created_at: 25.hours.ago))
        expect(old_tip.should_generate_new_friendly_id?).to be_falsy
      end
    end
  end
           
  describe '#title_must_be_unique_for_user' do
    context 'when tip with the same title already exists' do
      it 'should generate a validation error' do
        existing_tip = user.tips.create(attributes_for(:tip, title: 'Tip title'))
        new_tip = user.tips.create(attributes_for(:tip, title: 'Tip title'))
        expect(new_tip.errors.size).to be > 0
        expect(new_tip.errors[:title].first).to eq 'already exists. Please change it'
      end
    end
  end

  describe 'Default tip scope' do
    it 'should return the newer_tip first and older_tip second' do
      create(:tip, title: 'Older tip title', created_at: 1.day.ago, user: user)
      create(:tip, title: 'Newer tip title', created_at: 1.hour.ago, user: user)
      expect(Tip.all.map(&:title)).to eq(['Newer tip title', 'Older tip title'])
    end
  end
end
