# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  aasm :column => 'state' do
  end
  MAX_TITLE_LENGTH = 50
  MAX_DESCRIPTION_LENGTH = 1000

  belongs_to :category
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true, length: { maximum: MAX_TITLE_LENGTH }
  validates :description, presence: true, length: { maximum: MAX_DESCRIPTION_LENGTH }
  validates :image, attached: true, size: { less_than: 5.megabytes }

  def self.title_max_length
    MAX_TITLE_LENGTH
  end

  def self.description_max_length
    MAX_DESCRIPTION_LENGTH
  end
end
