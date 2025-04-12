class CreateSynonyms < ActiveRecord::Migration[7.2]
  def change
    create_table :synonyms do |t|
      t.string :boardid
      t.string :answer
      t.string :status

      t.timestamps
    end
  end
end
