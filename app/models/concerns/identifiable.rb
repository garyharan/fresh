module Identifiable
  extend ActiveSupport::Concern

  private

  def generate_id(column = :id)
    id = Nanoid.generate(size: 10, alphabet: '-0123456789abcdefghijklmnopqrstuvwxyz')

    while self.class.where(column => id).any?
      id = Nanoid.generate(size: 10, alphabet: '-0123456789abcdefghijklmnopqrstuvwxyz')
    end

    id
  end

  module ClassMethods
    def identifiable_by(column = :id)
      before_create do
        self[column] = generate_id(column)
      end
    end
  end
end
