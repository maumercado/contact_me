class Ability
  include CanCan::Ability

  def initialize(user)
    user ||=  User.new # guest user

    if user.roles.empty? or user.nil?
      cannot :read, :all
    end
    
    if user.role?(:user)
      can :read, User
      can :read, Group
      can :manage, Subscription
    end

    can :edit, User do |usr|
      usr == user || user.role?(:admin) 
    end

    if user.role?(:admin)
      can :manage, :all
    end

  end
end
