class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.role.user?
        can :manage, User, user_id: user.id
        can :manage, NaturalPerson, user_id: user.id
        can :manage, LegalPerson, user_id: user.id
      elsif user.role.admin?
      end
    end
  end
end