class JsonWebToken
  # Prioriza JWT_SECRET_KEY do .env, depois fallback para credentials ou secret_key_base
  SECRET_KEY = ENV["JWT_SECRET_KEY"] || Rails.application.credentials.secret_key_base || Rails.application.secrets.secret_key_base || "fallback_secret_key_for_development_only"

   def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, "HS256")
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: "HS256" })
    decoded[0]
  rescue JWT::DecodeError
    nil
  end
end
