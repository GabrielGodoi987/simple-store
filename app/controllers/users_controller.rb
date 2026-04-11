class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  before_action :authenticate_user, only: %i[ update destroy ]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    Rails.logger.debug "Params: #{params.inspect}"
    user = User.new(user_params)

    if user.save
      token = JsonWebToken.encode(user_id: user.id)

      render json: { user: user, meta: { token: token } }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  # GET /users/me
  def me
    render json: @current_user, serializer: UserSerializer
  end

  private

  def set_user
    @user = User.find(params.expect(:id))
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def authenticate_user
    header = request.headers["Authorization"]
    token = header&.split(" ")&.last
    payload = JsonWebToken.decode(token)

    @current_user = User.find_by(id: payload["user_id"])

    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end
end
