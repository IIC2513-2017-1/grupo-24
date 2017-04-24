module ApplicationHelper
  def check_active(path)
    path == request.original_url ? 'active' : ''
  end
end
