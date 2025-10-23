class AddSynonymsToBoards < ActiveRecord::Migration[7.2]
  def change
    add_column :boards, :synonyms, :text
  end
end
