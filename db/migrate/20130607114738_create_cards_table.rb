class CreateCardsTable < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :question
      t.string :answer
      t.references :deck
    end
  end
end
