require 'rails_helper'

RSpec.describe Users::CoursesController, type: :controller do
  # describe '#index' do
  #   let!(:course) { create :course }
  
  #   before { get :index }
  
  #   specify do
  #     expect(assigns(:courses)).to match_array [course]
  #   end
  # end
  
  # describe '#new' do
  #   before { get :new }
  
  #   specify do
  #     expect(assigns(:course)).to be_an_instance_of Course
  #   end
  # end
  
  # describe '#create' do
  #   context 'when success' do
  #     let(:params) { { title: 'Test course', picture: fixture_file_upload("pixel.png", "image/png") } }
  
  #     before { post :create, course: params }
  
  #     it 'should redirect to courses list' do
  #       expect(response).to redirect_to users_courses_path
  #     end
  #   end
  
  #   context 'when failure' do
  #     let(:params) { { title: 'Test course' * 10 } }
  
  #     before { post :create, course: params }
  
  #     it 'should render form with invalid data' do
  #       expect(assigns(:course)).to be_an_instance_of Course
  #       expect(response).to render_template :new
  #     end
  #   end
  # end
  
  # describe '#edit' do
  #   let(:course) { create :course }
  
  #   before { get :edit, id: course.id }
  
  #   specify do
  #     expect(assigns(:course)).to eq course
  #   end
  # end
  
  # describe '#update' do
  #   let!(:course) { create :course, title: 'Initial title' }
  
  #   context 'when success' do
  #     let(:params) { { title: 'Test course' } }
  
  #     before { put :update, id: course.id, course: params }
  
  #     it 'should update record and redirect to courses list' do
  #       expect(course.reload.title).to eq 'Test course'
  #       expect(response).to redirect_to courses_path
  #     end
  #   end
  
  #   context 'when failure' do
  #     let(:params) { { title: 'Test course' * 20 } }
  
  #     before { put :update, id: course.id, course: params }
  
  #     it 'should render form with invalid data' do
  #       expect(assigns(:course)).to be_an_instance_of Course
  #       expect(course.reload.title).to eq 'Initial title'
  #       expect(response).to render_template :edit
  #     end
  #   end
  # end
  
  # describe '#destroy' do
  #   let!(:course) { create :course }
  
  #   it 'should destroy record' do
  #     expect { delete :destroy, id: course.id }.to change { Course.count }.by(-1)
  #     expect(response).to redirect_to users_courses_path
  #   end
  # end
end
