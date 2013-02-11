class CreateHighScores < ActiveRecord::Migration
  def change
    create_table :high_scores do |t|
      t.integer :score
      t.integer :user_id

      t.timestamps
    end
		add_index :high_scores, :user_id
  end
end
