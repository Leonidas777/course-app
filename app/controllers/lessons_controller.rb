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

<<<<<<< HEAD
  helper_method :current_course
=======
  def asc_order?
    params[:order] != 'desc'
  end

  def author?
    current_user.id == current_course.user.id
  end

  def desc_order_lessons
    if user_signed_in? && author?
      return @lessons = current_course.lessons.desc_order.one_page(params[:page], params[:per_page])
    end
    @lessons = current_course.lessons.desc_order.one_page(params[:page], params[:per_page], true)
  end

  def asc_order_lessons
    if user_signed_in? && author?
      return @lessons = current_course.lessons.asc_order.one_page(params[:page], params[:per_page]) if user_signed_in? && author?
    end
    @lessons = current_course.lessons.asc_order.one_page(params[:page], params[:per_page], true)
  end

  helper_method :current_course, :asc_order?, :author?

  def load_lesson
    @lesson = Lesson.find(params[:id])
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:shared_key])
  end
>>>>>>> lesson-4
end
