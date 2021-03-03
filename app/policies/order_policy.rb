class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def show?
    record.user == user || record.lines.map { |line| line.meal.user }.uniq.include?(user)
  end

  def update?
    record.user == user
  end

  def new?
    return true
  end

end
