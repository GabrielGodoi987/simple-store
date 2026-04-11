module Trackable
  extend ActiveSupport::Concern

  included do
    before_action :track_controller_flow
  end

  private

  def track_controller_flow
    Rails.logger.info "Controller: #{self.class.name} | IP: #{request.remote_ip}"
  end
end
