class Users::CoursesController < Users::BaseController
  PER_PAGE = 3

  before_action :find_course, only: [:edit, :update, :destroy]

  def index
    @courses = current_user.authored_courses.recent.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def new
    return @course = current_user.authored_courses.build if current_user.has_role? :trainer
    redirect_after_creating 'Only trainer can add a new course.'
  end

  def create
    if current_user.has_role? :trainer
      @course = current_user.authored_courses.build(course_params)
      if @course.save
        redirect_after_creating 'The course was successfully added.'
      else
        render :new
      end
    else
      redirect_after_creating 'Only trainer can add a new course.'
    end
  end

  def update
    if @course.update(course_params)
      redirect_to users_courses_path
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @course.destroy

    redirect_to users_courses_path
  end

  private

  def course_params
    params.require(:course).permit(:title, :picture)
  end

  def find_course
    @course = current_user.authored_courses.find(params[:id])
  end

  def redirect_after_creating(message)
    flash['new_course'] = message
    redirect_to users_courses_path
  end
end
