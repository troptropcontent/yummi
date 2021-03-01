class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    return true
    # will have to add users to chat
    # record.user == user
  end

  def show?
    return true
    # will have to add users to chat
    # record.user == user
  end
end
