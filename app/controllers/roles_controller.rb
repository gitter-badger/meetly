

class RolesController < ApplicationController

  def get_role_price_table
    @role = Role.find_by(name: query_parameters[:name])
    if @role
      price_table = @role.price_table
      respond_to do |format|
        format.json{render :json => price_table.to_json, :status => 200, :callback => params['callback']}
      end
    else
      respond_to do |format|
        format.json{render :json => nil, :status => 422, :callback => params['callback']}
      end
    end
  end

  protected

  def query_parameters
    params.permit(:name)
  end


end