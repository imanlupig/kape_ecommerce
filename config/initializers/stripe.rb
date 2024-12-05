Stripe.api_key = Rails.application.credentials.dig(:stripe, :sk)

Rails.configuration.stripe = {
  secret_key: Rails.application.credentials.stripe[:sk],
  publishable_key: Rails.application.credentials.stripe[:pk]
}
