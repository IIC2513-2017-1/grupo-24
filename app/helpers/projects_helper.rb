module ProjectsHelper
  def expired?(project)
    return 'expired' if project.end_date < Date.today
    ''
  end
end
