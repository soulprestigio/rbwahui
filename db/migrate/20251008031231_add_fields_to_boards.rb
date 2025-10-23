class AddFieldsToBoards < ActiveRecord::Migration[7.2]
  def change
    remove_column :boards, :name, :string
    remove_column :boards, :status, :integer
    add_column :boards, :board_number, :integer
    add_column :boards, :board_name, :string
    add_column :boards, :board_synonyms, :text
    add_column :boards, :board_description, :text
    add_column :boards, :total_bet, :integer
  end
end
