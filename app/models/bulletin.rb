# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  MAX_TITLE_LENGTH = 50
  MAX_DESCRIPTION_LENGTH = 1000

  aasm :column => 'state' do
    state :draft, initial: true
    state :under_moderation, :rejected, :published, :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :archive do
      transitions from: [:draft, :under_moderation, :rejected, :published], to: :archived
    end
  end

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
