
Rails.configuration.stripe = {
  publishable_key: ENV['stripe_key'],
  secret_key: ENV['stripe_scret']
}
 
Stripe.api_key = ENV['stripe_scret']
 
StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded' do |event|
    # Here you can send notification to user,
    # change transaction state or whatever you want.
  end
end
