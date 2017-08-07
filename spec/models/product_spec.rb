require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do 
      @category = Category.new(name: 'test')
    end

    it 'should save when given a name, price, quantity, and category' do
      @product = Product.new(
        name: 'Tester Solution',
        price: 499,
        quantity: 99,
        category: @category
      )

      expect(@product.save!).to eq true
    end

    it 'should not save without a name' do
      @product = Product.new(
        price: 499,
        quantity: 99,
        category: @category
      )
      @product.save

      expect(@product.errors.messages).to eq({:name=>["can't be blank"]})
    end

    it 'should not save without a price' do
      @product = Product.new(
        name: 'Tester Solution',
        quantity: 99,
        category: @category
      )
      @product.save

      expect(@product.errors.messages).to eq({:price_cents=>["is not a number"], :price=>["is not a number", "can't be blank"]})
    end

    it 'should not save without a quantity' do
      @product = Product.new(
        name: 'Tester Solution',
        price: 499,
        category: @category
      )
      @product.save

      expect(@product.errors.messages).to eq({:quantity=>["can't be blank"]})
    end

    it 'should not save without a category' do
      @product = Product.new(
        name: 'Tester Solution',
        price: 499,
        quantity: 99
      )
      @product.save

      expect(@product.errors.messages).to eq({:category=>["can't be blank"]})
    end
  end
end
