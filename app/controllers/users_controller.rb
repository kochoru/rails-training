class UsersController < ApplicationController
  # GET /users
  def index
    @users = User.order('update_at DESC')
  end

  # POST /users
  def create
    # user_paramsの正体が不明で気持ち悪い
    @user = User.new(user_params)

    # 保存し、成功したかどうか
    if @user.save
      render :show, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

end