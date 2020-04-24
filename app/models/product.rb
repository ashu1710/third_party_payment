class Product < ApplicationRecord
  validates :name,  presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
 
  def price_in_cents
    (price * 100).to_i
  end

  serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: ENV["paypal_account"],
        cmd: "_xclick",
        upload: 1,
        return: "#{ENV['app_host']}#{return_path}",
        amount: self.price,
        item_name: self.name,
        item_number: self.id,
        quantity: '1',
    }
    "#{ENV['paypal_host']}/cgi-bin/webscr?" + values.to_query
  end

end
