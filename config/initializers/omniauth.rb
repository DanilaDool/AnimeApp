OmniAuth.config.allowed_request_methods = [:get]
OmniAuth.config.silence_get_warning = true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, '51822411', 'auexqcF72pKerlrxBTso', scope: 'email'
end
