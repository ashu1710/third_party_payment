json.extract! credit_card, :id, :digits, :cvc, :month, :year, :user_id, :created_at, :updated_at
json.url credit_card_url(credit_card, format: :json)
