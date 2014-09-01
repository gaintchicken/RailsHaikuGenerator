class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author
      t.integer :haikus_generated
      t.integer :times_viewed

      t.timestamps
    end
  end
end
