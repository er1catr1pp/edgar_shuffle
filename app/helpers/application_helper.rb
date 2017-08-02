module ApplicationHelper

  # this is sample application with only one user
  def current_user
    c_user = User.first
  end

  # connect rails flash messages to bootstrap alert styles
  def flash_class(level)
    case level
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-error"
      when 'alert' then "alert alert-error"
    end
  end

end
