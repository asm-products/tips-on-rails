require 'rails_helper'

describe User do
  let(:user) { build_stubbed(:user) }
  subject { user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:username) }
  it { should respond_to(:tips) }
  it { should respond_to(:bookmarks) }

  describe 'when all validations are satisfied' do
    it { should be_valid }
  end

  it { should validate_presence_of(:email) }

  describe 'validation on update' do
    it { should_not allow_value(' ').for(:first_name).on(:update) }
    it { should_not allow_value(' ').for(:last_name).on(:update) }
    it { should validate_length_of(:first_name).is_at_most(50).on(:update) }
    it { should validate_length_of(:last_name).is_at_most(50).on(:update) }
  end

  describe 'validation' do
    it do
      should_not allow_value(
        'user@foo,com', 'user_at_foo.org', 'example.user@foo.', 'foo@bar_baz.com',
        'foo@bar+baz.com'
      ).for(:email)
    end
  end

  describe 'validation' do
    it do
      should allow_value(
        'user@foo.COM', 'A_US-ER@f.b.org', 'frst.lst@foo.jp', 'a+b@baz.cn'
      ).for(:email)
    end
  end

  describe 'when email is mixed case' do
    before do
      user.email = 'USER@example.COM'
      user.save!
    end

    it 'should be downcased' do
      expect(user.email).to eq('user@example.com')
    end
  end

  describe 'when email address is already taken' do
    before do
      user_with_same_email = user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe 'when first name is Example and last name is User then #name' do
    it { expect(user.name).to eq('Example User') }
  end

  describe '#bookmarked_tips' do
    before do
      (0..3).each do |bookmarks_count|
        create(:tip, user: user, bookmarks_count: bookmarks_count)
      end
    end
    it 'should return how many times the user\'s tips have been bookmarked' do
      expect(user.bookmarked_tips).to eq(0 + 1 + 2 + 3)
    end
  end

  describe 'when authenticating with GitHub through OmniAuth' do
    Info = Struct.new(:email, :nickname, :name)
    Auth = Struct.new(:provider, :uid, :info)
    auth = Auth.new('github', '12345', Info.new('user@example.com', 'username', 'Fname Lname'))
    let(:new_user) { User.from_omniauth(auth) }

    describe 'without an existing account' do
      it 'should initialize a new user account' do
        expect(new_user).to be_a_new_record
        expect(new_user.provider).to eq('github')
        expect(new_user.uid).to eq('12345')
        expect(new_user.email).to eq('user@example.com')
        expect(new_user.username).to eq('username')
        expect(new_user.password).not_to be_empty
        expect(new_user.first_name).to eq('Fname')
        expect(new_user.last_name).to eq('Lname')
      end
    end

    describe 'with an existing account' do
      before do
        create(:user, provider: 'github', uid: '12345', username: 'existing_username')
      end

      let(:existing_user) { User.from_omniauth(auth) }

      it 'should return the existing user account' do
        expect(existing_user).to be_persisted
        expect(existing_user.username).to eq('existing_username')
      end
    end
  end
end
