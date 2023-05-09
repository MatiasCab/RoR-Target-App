class TargetService 
    MAX_TARGETS_AMOUNT = 10

    def initialize(current_user, params)
        @current_user = current_user
        @params = params
    end

    def call
        Target.transaction do
            max_targets_amount_reached?
            target = targets.create!(params)
            target
        end
    end

    private 

    def max_targets_amount_reached?
        raise StandardError unless targets.count < MAX_TARGETS_AMOUNT
    end

    def targets
        @targets ||= current_user.targets
    end
end