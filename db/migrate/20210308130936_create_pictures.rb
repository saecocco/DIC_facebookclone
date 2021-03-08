class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :index
      t.text :post

      t.timestamps
    end
  end
end
