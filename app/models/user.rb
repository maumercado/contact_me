class User < ActiveRecord::Base
  extend FriendlyId
  after_initialize :set_username
  before_create :set_as_user
  
  friendly_id :username, use: :slugged

  has_many :subscriptions, dependent: :destroy
  has_many :groups, through: :subscriptions
  
  ROLES = %w[admin user]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :twitter, :facebook, :landphone, :name, :cellphone, :username,
                  :roles, :group_ids
  # attr_accessible :title, :body

  validates :email, presence: true
  validates :name, presence: true

  validates_format_of :twitter, with: /^([a-zA-Z](_?[a-zA-Z0-9]+)*_?|_([a-zA-Z0-9]+_?)*)$/,
                                message: "invalid account",
                                allow_blank: true
                                
  validates_format_of :facebook, with: /(?:http:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-]*)/,
                                message: "invalid account url",
                                allow_blank: true

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def role?(role)
    roles.include? role.to_s
  end

  def self.search(query)
    where do
      ((name =~ "%#{query}%") | (twitter =~ "%#{query}%") | 
        (facebook =~ "%#{query}%") | (email =~ "%#{query}%"))
    end
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  private
  def set_username
    self.username = self.email.split('@')[0]
  end

  def set_as_user
    if self.roles.empty?
      self.roles=(['user'])
    end
  end
end
