require 'rails_helper'

RSpec.describe CartItem, type: :model do
  subject { CartItem.new(attributes_for(:cart_item)) }

  describe 'validation' do
    it { is_expected.to validate_presence_of(:product_id) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:product_id).only_integer }
    it {
      is_expected.to validate_numericality_of(:quantity)
        .only_integer
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(10)
    }
  end

  context 'with valid product_id' do
    it { is_expected.to be_valid }

    it 'calculates the sum' do
      expect(subject.sum).to eq(Product.find(subject.product_id).price * subject.quantity)
    end
  end

  context "when product doesn't exist" do
    subject { build(:cart_item, product_id: 999) }

    it { is_expected.to be_invalid }

    it 'sets sum to 0' do
      expect(subject.sum).to eq 0
    end

    it 'has an error' do
      subject.valid?
      expect(subject.errors[:product_id]).to eq ["doesn't exist"]
    end
  end
end
