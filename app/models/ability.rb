class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, User
    can :read, NaturalPerson
    can :read, LegalPerson
    if user
      if user.role.user?
        can :manage, NaturalPerson, user_id: user.id
        can :manage, LegalPerson, user_id: user.id
      elsif user.role.admin?
        end
      end
    end
  end
end