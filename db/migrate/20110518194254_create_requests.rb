class CreateRequests < ActiveRecord::Migration
  def change
    create_table :help_requests do |t|
      t.references :requester
      t.references :hero
      t.string :title
      t.text :description

      t.timestamps
    end
    add_index :help_requests, :requester_id
    add_index :help_requests, :hero_id
  end
end
