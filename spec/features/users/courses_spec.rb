require 'rails_helper'

RSpec.describe 'Courses Page', type: :feature do
  #
  # describe 'Index Page' do
  #   let!(:course) { create :course }
  #
  #   before { visit courses_path }
  #
  #   it 'should display course title' do
  #     expect(page).to have_content course.title
  #   end
  #
  #   it 'should display course title' do
  #     expect(page).to have_content course.title
  #   end
  # end
  #
  # describe 'Create course' do
  #   before { visit courses_path }
  #   before { click_on 'New course' }
  #
  #   specify do
  #     within "form#new_course" do
  #       fill_in 'Title', with: 'Test title'
  #       attach_file('Picture', "#{Rails.root}/spec/fixtures/pixel.png")
  #
  #       click_on 'Save'
  #     end
  #
  #     expect(current_path).to eq courses_path
  #     expect(page).to have_content 'Test title'
  #   end
  # end
  #
  # describe 'Update course' do
  #   let!(:course) { create :course, title: 'Initial title' }
  #
  #   before { visit courses_path }
  #   before { click_on 'Edit' }
  #
  #   specify do
  #     within "form#edit_course_#{course.id}" do
  #       fill_in 'Title', with: 'Test title'
  #
  #       click_on 'Save'
  #     end
  #
  #     expect(current_path).to eq courses_path
  #     expect(page).to have_content 'Test title'
  #     expect(page).to_not have_content 'Initial title'
  #   end
  # end
  #
  # describe 'Destroy course' do
  #   let!(:course) { create :course, title: 'Initial title' }
  #
  #   before { visit courses_path }
  #   before { click_on 'Delete' }
  #
  #   specify do
  #     expect(current_path).to eq courses_path
  #     expect(page).to have_content 'No courses'
  #     expect(page).to_not have_content 'Initial title'
  #   end
  # end
end
