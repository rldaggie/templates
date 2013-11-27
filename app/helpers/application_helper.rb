module ApplicationHelper
  def close_button
    content_tag :button, '&times;'.html_safe, class: 'close', data: { dismiss: 'alert' }
  end
  
  def caret
    content_tag :span, '', class: 'caret'
  end
end
