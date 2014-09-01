class Book < ActiveRecord::Base
  validates :md5, uniqueness: true
  attr_accessible :author, :haikus_generated, :times_viewed, :text_file, :md5, :markov_chain
  serialize :markov_chain, Hash
  mount_uploader :text_file, TextFileUploader

  def generate_markov_chains
    f = File.open("#{Rails.root}/public/"+self.text_file_url, "r")
    first_word = ''
    second_word = ''
    word_hash = Hash.new
    f.each_line do |line|
      line = remove_punctuation(line)
      line.split.each do |word|
        add_to_hash(word_hash, first_word, second_word, word) if first_word && second_word != ''
        first_word = second_word
        second_word = word
      end
    end
    self.markov_chain = word_hash
    self.save!
  end
  def remove_punctuation(line)
    puts line
    puts line.encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "?")
    line = line.encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "?").gsub(/[,'.;]/, '')
    line
  end
  def add_to_hash(word_hash, word1, word2, next_word)
    arr = [word1, word2]
    if word_hash[arr] != nil
      word_hash[arr] = word_hash[arr] << next_word #if it already exists, add don't create new
    else
      word_hash[arr] = [next_word]
    end
    word_hash
  end
end