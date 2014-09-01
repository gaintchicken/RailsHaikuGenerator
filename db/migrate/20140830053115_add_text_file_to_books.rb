class AddTextFileToBooks < ActiveRecord::Migration
  def change
    add_column :books, :text_file, :string
  end
end
