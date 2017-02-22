require "external_id/version"

module ExternalId
  extend ActiveSupport::Concern

  included do
    def _initialize_external_id(attribute, params)
      if send(attribute).blank?
        send("#{attribute}=", self.class._generate_external_id(params[:prefix], params[:bytes]))
      end
    end
  end

  module ClassMethods
    def external_id(attribute = :external_id, params)
      validates_uniqueness_of attribute

      params = { prefix: "", bytes: 4 }.merge params
      before_create { _initialize_external_id(attribute, params) }
    end

    def _generate_external_id(prefix = "", bytes = 4)
      loop do
        random_token = prefix + SecureRandom.hex(bytes).upcase
        break random_token unless exists?(external_id: random_token)
      end
    end
  end
end
