module Turbo
  class DeviseFailureApp < Devise::FailureApp
    def hotwire_native_app?
      false
    end

    def turbo_native_app?
      false
    end
  end
end
