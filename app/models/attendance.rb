class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum :status, { requested: 0, approved: 1, waitlisted: 2, denied: 3 }
end
