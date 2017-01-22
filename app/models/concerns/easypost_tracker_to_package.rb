# frozen_string_literal: true
module EasypostTrackerToPackage
  refine EasyPost::Tracker do
    def to_package_attrs
      {
        tracking_number: tracking_code,
        carrier: carrier,
        easypost_tracking_id: id,
        status: status,
        estimated_delivery_date: est_delivery_date,
      }
    end
  end
end
