class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title
  delegate :current_user, to: :scope

  def url
    course_url(object)
  end

  def attributes
    data = super
    data[:url] = url if current_user.present?

    data
  end
end
