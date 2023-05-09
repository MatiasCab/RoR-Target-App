module Api
    module V1
        class TargetsController <  Api::V1::ApiController
            def create
                authorize Target
                @target = Target.new(resource_params)

                if !@target.save
                    render json: {error: @target.errors.full_messages}, status: :unprocessable_entity
                end
            end

            def resource_params
                params.require(:target).permit(:title, :lat, :lng, :radius, :topic_id).merge(user_id: current_user.id)
            end
        end
    end
end
