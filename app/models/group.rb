class Group < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  attr_accessible :name, :slug, :description

  validates :name, presence: true

  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  def self.search(query)
    where do
      ((name =~ "%#{query}%"))
    end
  end
end
