class AddTextFileHashToBook < ActiveRecord::Migration
  def change
    add_column :books, :md5, :text
  end
end
