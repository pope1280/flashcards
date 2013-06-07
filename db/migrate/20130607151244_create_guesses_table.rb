class CreateGuessesTable < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.references :round
      t.references :card
      t.string :result
    end
  end
end
