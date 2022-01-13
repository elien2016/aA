require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double('chef', :titleize => "Chef Pierre the Great Baker")}
  subject(:dessert) { Dessert.new('macaron', 50, chef) } 

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq('macaron')
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(50)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients). to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new('macaron', '50', 'Pierre') }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient('flour')
      expect(dessert.ingredients.first).to eq('flour')
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      dessert.add_ingredient('flour')
      dessert.add_ingredient('eggs')
      dessert.add_ingredient('sugar')
      dessert.add_ingredient('butter')
      ingredients_prev = []
      ingredients_prev += dessert.ingredients
      dessert.mix!
      expect(dessert.ingredients).to_not eq(ingredients_prev)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      amt_prev = dessert.quantity
      dessert.eat(5)
      expect(dessert.quantity).to eq(amt_prev - 5)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(100) }.to raise_error(RuntimeError)
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(dessert.serve).to include(chef.titleize)
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
