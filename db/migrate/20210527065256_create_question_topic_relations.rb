class CreateQuestionTopicRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :question_topic_relations do |t|
      t.integer :topic_id
      t.integer :question_id

      t.timestamps
    end

    add_index :question_topic_relations, :topic_id
    add_index :question_topic_relations, :question_id
    add_index :question_topic_relations, [:topic_id, :question_id], unique: true
  end
end
