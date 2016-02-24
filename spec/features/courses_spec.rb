require 'rails_helper'

RSpec.describe 'Courses Page', type: :feature do

  describe 'Index Page' do
    let!(:course) { create :course }

    before { visit users_courses_path }

    it 'should display course title' do
      expect(page).to have_content course.title
    end

    it 'should display course title' do
      expect(page).to have_content course.title
    end
  end
end
