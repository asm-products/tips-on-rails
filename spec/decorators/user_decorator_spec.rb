require 'rails_helper'

describe UserDecorator do
  let(:user) { FactoryGirl.build_stubbed(:user) }

  describe 'when avatar size is not set' do
    it 'should display github picture with size 80' do
      decorated_user = user.decorate
      expect(decorated_user.display_avatar).to match(%r{githubusercontent.com/u/12345\?s=80})
      expect(decorated_user.display_avatar).to match(/width="80"/)
    end
  end

  describe 'when avatar set to 150' do
    it 'should display github picture with size 150' do
      decorated_user = user.decorate
      expect(decorated_user.display_avatar(size: 150)).to match(%r{githubusercontent.com/u/12345\?s=150})
      expect(decorated_user.display_avatar(size: 150)).to match(/width="150"/)
    end
  end
end
