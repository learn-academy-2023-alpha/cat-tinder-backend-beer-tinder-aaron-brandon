class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def record_not_found(exception)
        render json: {status: "error", code:404, message: "Record not found" }, status: :not_found
    end
end
