require 'spec_helper'
 
describe GildedRose do

  describe "#initialize" do
    it "initializes an array of Items and stores it in @items" do
      item1 = Item.new("item_1","item_sell_in","item_quality")
      item2 = Item.new("item_2","item_sell_in","item_quality")
      items = [item1,item2]
      gilded_rose = GildedRose.new(items)
      expect(gilded_rose.instance_variable_get("@items")).to eq(items)
    end
  end

  describe "#update_quality" do
    context "Sulfuras" do
      it "does" do
      
      end
    end

    context "Aged Brie" do
      it "does" do
      
      end
    end

  end

end