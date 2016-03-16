class VisibleLessonsController < ApplicationController
  before_filter :authenticate_user!

  def create
    lesson.show!
  end

  def destroy
    lesson.hide!
  end

  private

  def lesson
    @lesson ||= Lesson.find(params[:id])
  end

  helper_method :lesson
end
