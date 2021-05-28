class FixVoteUniqueness < ActiveRecord::Migration[6.1]
  def change
    add_index :votes, [:user_id, :answer_id], unique: true
  end
end
