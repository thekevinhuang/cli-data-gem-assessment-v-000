#Qualities of a Amazon item

#Name
#Price
#maker
#Prime?
#Rating
#features
#colors?
# in stock
#seller
class Amazon_Item
  attr_accessor :name, :price, :maker, :prime, :rating, :features, :colors, :in_stock, :seller, :link
  @@all = []

  def initialize(item_hash)
    item_hash.each do |key, value|
      self.send "#{key}=" , "#{value}"
    end
    @@all <self
  end

  def add_attributes(new_hash)
    new_hash.each do |key, value|
      self.send "#{key}=" , "#{value}"
    end
    self
  end
