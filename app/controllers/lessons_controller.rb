class LessonsController < ApplicationController
  PER_PAGE = 6

  def index
    @lessons = current_course.lessons.only_visible_by_position.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  private

  def current_course
    @current_course ||= Course.find(params[:course_id])
  end

  helper_method :current_course
end
