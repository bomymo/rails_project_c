require 'rails_helper'

describe Product do
  context "when the product has comments" do
    let (:product) { Product.create!(name: "Batman Movie DVD", description: "test", colour: "black", price: 1.00, image_url: "test") }
    let (:user) { User.create(email: "jtest@email.com", password: "moonstone") }
    before do
      product.comments.create!(rating: 1, user: user, body: "Awful!")
      product.comments.create!(rating: 3, user: user, body: "OK")
      product.comments.create!(rating: 5, user: user, body: "Terrific!")
    end

    it "returns the average rating of all comments" do
      expect(product.average_rating).to eq 3
    end

    it "is not valid without a name" do
      expect(Product.new(description: "test", colour: "black", price: 1.00, image_url: "test")).not_to be_valid
    end
    it "is not valid without a description" do
      expect(Product.new(name: "Test item", colour: "black", price: 1.00, image_url: "test")).not_to be_valid
    end
    it "is not valid without a colour" do
      expect(Product.new(name: "Test item", description: "test", price: 1.00, image_url: "test")).not_to be_valid
    end      
    it "is not valid without a price" do
      expect(Product.new(name: "Test item", description: "test", colour: "black", image_url: "test")).not_to be_valid
    end      
    it "is not valid with a price less than .01" do
      expect(Product.new(name: "Test item", description: "test", colour: "black", price: 0, image_url: "test")).not_to be_valid
    end
    it "is not valid without an image_url" do
      expect(Product.new(name: "Test item", description: "test", colour: "black", price: 1.00)).not_to be_valid
    end

    it "is not valid without a rating" do
      expect(product.comments.new(user: user, body: "test")).not_to be_valid
    end
     it "is not valid if rating is not numeric" do
      expect(product.comments.new(rating: "X", user: user, body: "test")).not_to be_valid
    end
    it "is not valid without a user" do
      expect(product.comments.new(rating: 1, body: "test")).not_to be_valid
    end
    it "is not valid without a body" do
      expect(product.comments.new(rating: 1, user: user)).not_to be_valid
    end
  end
end


