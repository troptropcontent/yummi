class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def show?
      record.user == user || record.lines.map { |line| line.meal.user }.unique.include?(user)
    end

    def update?
      record.user == user
    end
  end
end
