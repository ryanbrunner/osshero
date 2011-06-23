class CreateHelpResponses < ActiveRecord::Migration
  def change
    create_table :help_responses do |t|
      t.references :user
      t.references :help_request
      t.boolean :completed
      t.string :repository

      t.timestamps
    end
    add_index :help_responses, :user_id
    add_index :help_responses, :help_request_id
  end
end
