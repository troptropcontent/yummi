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
    # return true
    record.order.user == user || record.order.lines.first.meal.user == user
    # must verify that order users are the only one to access
    # record == chatroom
    # record.order
    # will have to add users to chat
    # record.user == user
  end
end
