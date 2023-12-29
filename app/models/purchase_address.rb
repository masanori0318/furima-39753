class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city_id, :house_number, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :city_id
    validates :house_number
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/ }
    validates :user_id
    validates :item_id
    validates :token
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  end

  def save
    purchase = Purchase.create(user_id:, item_id:)

    Address.create(post_code:, prefecture_id:, city_id:, house_number:,
                   building:, phone_number:, purchase_id: purchase.id)
  end
end
