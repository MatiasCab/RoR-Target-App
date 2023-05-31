class CreateMatchUsersConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :match_users_conversations do |t|
      t.references :user, foreign_key: true, null: false
      t.references :target, foreign_key: true, null: false
      t.references :conversation, foreign_key: true, null: false

      t.timestamps
    end
  end
end
