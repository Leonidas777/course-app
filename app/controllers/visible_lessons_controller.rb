class VisibleLessonsController < ApplicationController
  before_action :authenticate_user!

  def create
    lesson.visible = true
    lesson.save!
  end

  def destroy
    lesson.visible = false
    lesson.save!
  end

  private

  def lesson
    @lesson ||= Lesson.find(params[:id])
  end
  helper_method :lesson
end
