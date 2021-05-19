# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    #acceso a todo con manage
    can :manage, Task, owner_id: user.id
    can :read, Task, participating_users: {user_id: user.id} 
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end

end
