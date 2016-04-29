class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when "Backstage passes to a TAFKAL80ETC concert"
        if item.quality < 50
          item.quality += 1
          if item.sell_in < 6 && item.quality < 50
            item.quality += 2
          elsif item.sell_in < 11 && item.quality < 50
            item.quality += 1
          end
        end
        if item.sell_in < 1
          item.quality = 0
        end
      when "Aged Brie"
        if item.quality < 50
          item.quality = item.quality + 1
        end
      when "Sulfuras, Hand of Ragnaros"
      when "Conjured Item"
        if item.quality > 0
          item.quality = item.quality - 2
          if item.sell_in < 0 && item.quality > 0
            item.quality = item.quality - 2
          end
        end
      else
        if item.quality > 0
          item.quality = item.quality - 1
          if item.sell_in < 0 && item.quality > 0
            item.quality = item.quality - 1
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
