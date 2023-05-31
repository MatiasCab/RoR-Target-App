class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :topic, foreign_key: true, null: false

      t.timestamps
    end
  end
end
