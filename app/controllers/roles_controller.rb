class RolesController < ApplicationController
  respond_to :json, :js

  def get_role_price_table
    @role = Role.find_by(name: query_parameters[:name])
    if @role
      price_table = @role.price_table
      respond_with price_table.to_json, status: 200, callback: params['callback'], content_type: "application/javascript"
    else
      respond_with nil, status: 422, content_type: "application/javascript"
    end
  end

  protected

  def query_parameters
    params.permit(:name)
  end
end
