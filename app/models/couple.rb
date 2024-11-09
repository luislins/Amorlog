class Couple < ApplicationRecord
  has_many :events, dependent: :destroy

  def to_param
    slug
  end
end
