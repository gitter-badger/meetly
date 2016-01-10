crumb :root do
  link 'Home', root_path
end

crumb :participants do
  link 'Uczestnicy', event_participants_path
end

crumb :dashboard do
  link 'Pulpit', event_dashboard_path
end

crumb :participant do |participant|
  link participant.full_name, edit_event_participant_path(event, participant)
  parent :participants
end

crumb :new_participant do |participant|
  link 'Dodaj uczestnika', new_event_participant_path(event)
  parent :participants
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
