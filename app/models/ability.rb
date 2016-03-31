class Ability
  include CanCan::Ability

  def initialize(user, shared_key=nil)
    user ||= User.new

    can :read, Lesson do |lesson|
      shared_key.present? && lesson.shared_key == shared_key
    end

    can :read, Lesson do |lesson|
      lesson.course.course_users.exists?(user_id: user.id)
    end

    can :manage, Lesson do |lesson|
      lesson.course.user == user
    end

    can :create, :course do
      user.has_role? :trainer
    end
  end
end
