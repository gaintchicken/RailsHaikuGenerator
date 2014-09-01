class AddMarkovChainToBook < ActiveRecord::Migration
  def change
    add_column :books, :markov_chain, :text
  end
end
