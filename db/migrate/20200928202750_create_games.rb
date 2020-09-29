class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :difficulty
      t.string :word
      t.string :hint
      t.integer :available_guesses, :default => 6
    end
  end
end


