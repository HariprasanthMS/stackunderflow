class FixVoteColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :votes, :type, :vote_type
  end
end
