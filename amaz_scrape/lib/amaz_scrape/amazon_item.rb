class AmazScrape::Amazon_Item
  attr_accessor :name, :price, :maker, :prime, :rating, :features, :colors, :in_stock, :seller, :link

  @@all = []

  def initialize(item_hash)
    item_hash.each do |key, value|
      self.send "#{key}=" , "#{value}"
    end
    @@all << self
  end

  def add_attributes(new_hash)
    new_hash.each do |key, value|
      self.send "#{key}=" , "#{value}"
    end
    self
  end

  def self.list_all
    @@all
  end

  def self.clear_all
    @@all.clear
  end

end
