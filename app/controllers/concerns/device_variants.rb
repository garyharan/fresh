module DeviceVariants
  extend ActiveSupport::Concern

  included do
    before_action :set_variant
  end

  def set_variant
    request.variant = :turbo_native if request.user_agent =~ /Turbo Native/
  end
end
