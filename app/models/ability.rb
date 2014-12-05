class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.role.user?
        can :manage, User, id: user.id
        can :create, NaturalPerson do |person|
          user.legal_person.nil? && user.natural_person.nil? 
        end
        can [:edit,:update,:destroy], NaturalPerson, user_id: user.id
        can :create, LegalPerson do |person|
          user.legal_person.nil? && user.natural_person.nil? 
        end
        can [:edit,:update,:destroy], LegalPerson, user_id: user.id
        can [:create,:set_kind], Credit 
      elsif user.role.security?
        can [:read,:change_state], Credit, state: "new"
        can :manage, User, id: user.id
      elsif user.role.analizer?
        can [:read,:change_state], Credit, state: "secured"
        can :manage, User, id: user.id
      elsif user.role.admin?
        can [:read,:change_state], Credit, state: ["approved", "rejected", "committed"]
        can [:read, :update, :destroy], NaturalPerson
        can [:read, :update, :destroy], LegalPerson
        can :manage, User
        can [:create_contract,:contract_field], Credit
      end   
    end
  end
end