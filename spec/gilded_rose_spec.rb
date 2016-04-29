require 'spec_helper'
 
describe GildedRose do

  describe "#initialize" do
    it "initializes an array of Items and stores it in @items" do
      item = Item.new("item",10,50)
      stage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert",10,40)
      sulfuras = Item.new("Sulfuras, Hand of Ragnaros",100,80)
      aged_brie = Item.new("Aged Brie",10,40)
      items = [item,stage_pass,sulfuras,aged_brie]
      gilded_rose = GildedRose.new(items)
      expect(gilded_rose.instance_variable_get("@items")).to eq(items)
    end
  end

  describe "#update_quality" do
    context "regular item" do
      it "degrades in quality" do
        item = Item.new("item_1",10,50)
        gilded_rose = GildedRose.new([item])
        expect{gilded_rose.update_quality}.to change{item.quality}.from(50).to(49)
      end
      it "decreases sell_in count" do
        item = Item.new("item_1",10,50)
        gilded_rose = GildedRose.new([item])
        expect{gilded_rose.update_quality}.to change{item.sell_in}.from(10).to(9)
      end
      it "never sets quality to less than 0" do
        item = Item.new("item_1",10,50)
        gilded_rose = GildedRose.new([item])
        51.times{gilded_rose.update_quality}
        expect(item.quality).to eq(0) 
      end
      context "sell date has passsed" do
        it "degrades in quality twice as fast" do
          item = Item.new("item_1",-1,50)
          gilded_rose = GildedRose.new([item])
          expect{gilded_rose.update_quality}.to change{item.quality}.from(50).to(48)
        end
      end
    end
    context "Stage Pass" do
      it "sets quality to 0 after due date" do
        stage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert",0,40)
        gilded_rose = GildedRose.new([stage_pass])
        gilded_rose.update_quality
        expect(stage_pass.quality).to eq(0) 
      end
      context "10 days or less" do
        it "increases in quality by 2" do
          stage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert",10,40)
          gilded_rose = GildedRose.new([stage_pass])
          expect{gilded_rose.update_quality}.to change{stage_pass.quality}.from(40).to(42)
        end
        it "decreases sell_in count" do
          stage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert",10,40)
          gilded_rose = GildedRose.new([stage_pass])
          expect{gilded_rose.update_quality}.to change{stage_pass.sell_in}.from(10).to(9)
        end
      end
      context "5 days or less" do
        it "increases in quality by 3" do
          stage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert",5,40)
          gilded_rose = GildedRose.new([stage_pass])
          expect{gilded_rose.update_quality}.to change{stage_pass.quality}.from(40).to(43)
        end
        it "decreases sell_in count" do
          stage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert",5,40)
          gilded_rose = GildedRose.new([stage_pass])
          expect{gilded_rose.update_quality}.to change{stage_pass.sell_in}.from(5).to(4)
        end
      end
      context "more than 10 days" do
        it "increases in quality" do
          stage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert",11,40)
          gilded_rose = GildedRose.new([stage_pass])
          expect{gilded_rose.update_quality}.to change{stage_pass.quality}.from(40).to(41)
        end
        it "decreases sell_in count" do
          stage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert",11,40)
          gilded_rose = GildedRose.new([stage_pass])
          expect{gilded_rose.update_quality}.to change{stage_pass.sell_in}.from(11).to(10)
        end
      end
    end
    context "Aged Brie" do
      it "increases in quality" do
        aged_brie = Item.new("Aged Brie",10,40)
        gilded_rose = GildedRose.new([aged_brie])
        expect{gilded_rose.update_quality}.to change{aged_brie.quality}.from(40).to(41)
      end
      it "does not go above 50 quality" do
        aged_brie = Item.new("Aged Brie",10,40)
        gilded_rose = GildedRose.new([aged_brie])
        expect{11.times{gilded_rose.update_quality}}.to change{aged_brie.quality}.from(40).to(50)
      end
      it "decreases sell_in count" do
        aged_brie = Item.new("Aged Brie",10,40)
        gilded_rose = GildedRose.new([aged_brie])
        expect{gilded_rose.update_quality}.to change{aged_brie.sell_in}.from(10).to(9)
      end
    end
    context "Sulfuras" do
      it "does not decrease sell_in count" do
        sulfuras = Item.new("Sulfuras, Hand of Ragnaros",100,80)
        gilded_rose = GildedRose.new([sulfuras])
        expect{gilded_rose.update_quality}.to_not change{sulfuras.sell_in}
      end
      it "never degrades in quality" do
        sulfuras = Item.new("Sulfuras, Hand of Ragnaros",100,80)
        gilded_rose = GildedRose.new([sulfuras])
        81.times{gilded_rose.update_quality}
        expect(sulfuras.quality).to eq(80) 
      end
    end
    context "Conjured Item" do
      it "degrades in quality" do
        conjured_item = Item.new("Conjured Item",10,50)
        gilded_rose = GildedRose.new([conjured_item])
        expect{gilded_rose.update_quality}.to change{conjured_item.quality}.from(50).to(48)
      end
      it "decreases sell_in count" do
        conjured_item = Item.new("Conjured Item",10,50)
        gilded_rose = GildedRose.new([conjured_item])
        expect{gilded_rose.update_quality}.to change{conjured_item.sell_in}.from(10).to(9)
      end
      it "never sets quality to less than 0" do
        conjured_item = Item.new("Conjured Item",10,50)
        gilded_rose = GildedRose.new([conjured_item])
        51.times{gilded_rose.update_quality}
        expect(conjured_item.quality).to eq(0) 
      end
      context "sell date has passsed" do
        it "degrades in quality twice as fast" do
          conjured_item = Item.new("Conjured Item",-1,50)
          gilded_rose = GildedRose.new([conjured_item])
          expect{gilded_rose.update_quality}.to change{conjured_item.quality}.from(50).to(46)
        end
      end
    end
  end
end