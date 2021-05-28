class CreateUserTopicRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :user_topic_relations do |t|
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end

    add_index :user_topic_relations, :user_id
    add_index :user_topic_relations, :topic_id
    add_index :user_topic_relations, [:user_id, :topic_id], unique: true
  end
end
