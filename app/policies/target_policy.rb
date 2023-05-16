class TargetPolicy < ApplicationPolicy
  MAX_TARGETS_AMOUNT = 3

  def create?
    raise Sala unless user.targets.count < MAX_TARGETS_AMOUNT

    true
  end
end
