class LessonsController < ApplicationController
  before_filter :load_lesson, only: :show
  authorize_resource only: :show
  PER_PAGE = 6

  def index
    @lessons = current_course.lessons.only_visible_by_position.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def show
  end

  private

  def current_course
    @current_course ||= Course.find(params[:course_id])
  end
  helper_method :current_course

  def load_lesson
    @lesson = Lesson.find(params[:id])
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:shared_key])
  end

  def author?
   current_user.id == current_course.user.id
  end
  helper_method :author?
end
