class HomeworkDecorator < Draper::Decorator
  delegate_all

  HTML_STATUS_CLASS_NAMES = {
    'pending' => 'warning',
    'approved' => 'success',
    'rejected' => 'danger'
  }

  def define_html_status_class_name
    HTML_STATUS_CLASS_NAMES[aasm.current_state.to_s]
  end

  def creating_date
    return created_at.strftime('at %I:%M%p, %B %d, %Y') if created_at.present?
    'undefined'
  end
end
