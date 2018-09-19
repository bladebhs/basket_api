require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let!(:product) { create(:product) }
  subject { CartItem.new(product_id: product.id, quantity: 1) }

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

  context 'after validation' do
    it { is_expected.to be_valid }

    it 'calculates the sum' do
      subject.valid?
      expect(subject.sum).to eq(product.price * subject.quantity)
    end
  end

  context "when product doesn't exist" do
    subject { CartItem.new(product_id: 999, quantity: 1) }

    it { is_expected.to be_invalid }

    it 'has an error' do
      subject.valid?
      expect(subject.errors[:product_id]).to eq ["doesn't exist"]
    end
  end
end
