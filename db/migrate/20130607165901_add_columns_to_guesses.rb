class AddColumnsToGuesses < ActiveRecord::Migration
  def change
    add_column :guesses, :user_answer, :string
  end
end
