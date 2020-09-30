class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :difficulty
      t.string :word, :default => nil
      t.string :hint, :default => nil
      t.integer :available_guesses, :default => 6
    end
  end
end


