class Group < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :members,
                          class_name: "User",
                          join_table: :groups_users

  validates_presence_of :name
end
