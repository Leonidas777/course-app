class Users::LessonsController < Users::BaseController
  PER_PAGE = 6

  def index
    @lessons = current_user.courses.find(current_course).lessons.all_by_position.includes(:course).page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  def new
    @lesson = current_course.lessons.build
  end

  def create
    @lesson = current_course.lessons.build(lesson_params)

    if @lesson.save!
      redirect_to users_lessons_path(course_id: current_course.id)
    else
      render :new
    end
  end

  def destroy
    @lesson.destroy
  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :picture, :position, :description, :picture, :summary, :homework, :meeting_datetime)
  end

  def current_course
    @current_course ||= current_user.courses.find(params[:course_id])
  end
  helper_method :current_course
end
