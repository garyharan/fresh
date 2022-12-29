class Group < ApplicationRecord
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :description

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  before_create :set_slug

  private

  def set_slug
    self.slug = generate_nanoid
  end

  def generate_nanoid
    slug = Nanoid.generate(size: 10, alphabet: '-0123456789abcdefghijklmnopqrstuvwxyz')

    while Group.where(slug: slug).any?
      slug = Nanoid.generate(size: 10, alphabet: '-0123456789abcdefghijklmnopqrstuvwxyz')
    end

    slug
  end
end
