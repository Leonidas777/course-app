class ActivityDecorator < Draper::Decorator
  delegate_all
  def partial_name
    object.trackable_type.underscore
  end

  STATUS_NAMES = {
    '0' => 'loaded',
    '1' => 'pending',
    '2' => 'approved',
    '3' => 'rejected'
  }

  HTML_STATUS_CLASS_NAMES = {
    '0' => 'primary',
    '1' => 'warning',
    '2' => 'success',
    '3' => 'danger'
  }

  def define_status_name
    STATUS_NAMES[kind.to_s]
  end

  def define_html_status_class_name
    HTML_STATUS_CLASS_NAMES[kind.to_s]
  end

  def creating_date
    return created_at.strftime('at %I:%M%p, %B %d, %Y') if created_at.present?
    'undefined'
  end
end
