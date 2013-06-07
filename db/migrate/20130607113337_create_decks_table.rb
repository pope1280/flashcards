class CreateDecksTable < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :topic
      t.references :user
    end
  end
end
