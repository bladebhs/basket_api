class ApplicationController < ActionController::API
  def not_found
    render json: {
      error: {
        type: "invalid_request_error",
        message: "Unable to resolve the request \"#{params[:unmatched_route]}\"."
      }
    }, status: 404
  end
end
