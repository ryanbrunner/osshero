class AddProjectToHelpRequest < ActiveRecord::Migration
  def change
    add_column :help_requests, :project_id, :integer
  end
end
