class CreateBooks < ActiveRecord::Migration[5.2]
  def up
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :author

      t.timestamps
    end
  end

  def down
    drop_table :books
  end
end
