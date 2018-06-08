class Api::UsersController < ApplicationController
  before_action :set_api_user, only: [:show, :update, :destroy]

  # GET /api/users
  # GET /api/users.json
  def index
    @api_users = Api::User.all
  end

  # GET /api/users/1
  # GET /api/users/1.json
  def show
  end

  # POST /api/users
  # POST /api/users.json
  def create
    @api_user = Api::User.new(api_user_params)

    if @api_user.save
      render :show, status: :created, location: @api_user
    else
      render json: @api_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/users/1
  # PATCH/PUT /api/users/1.json
  def update
    if @api_user.update(api_user_params)
      render :show, status: :ok, location: @api_user
    else
      render json: @api_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/users/1
  # DELETE /api/users/1.json
  def destroy
    @api_user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_user
      @api_user = Api::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_user_params
      params.fetch(:api_user, {})
    end
end
