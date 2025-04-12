class CreateWahuiboards < ActiveRecord::Migration[7.2]
  def change
    create_table :wahuiboards do |t|
      t.string :title
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
