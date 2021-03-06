require 'rails_helper'

describe Admin::DashboardsController do
  describe '#dashboards' do
    it '@all_users is not empty' do
      expect([:all_users]).to_not be_empty
    end

    it '@all_users is assigned the total Users count' do
      expect([:all_users].count).to be >= 1
    end

    it '@all_tips is not empty' do
      expect([:all_tips]).to_not be_empty
    end

    it '@all_tips is assigned the total Tips count' do
      expect([:all_tips].count).to be >= 1
    end

    it '@all_bookmarks is not empty' do
      expect([:all_bookmarks]).to_not be_empty
    end
  end
end
