class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  
  # GET /api/v1/users
  def index
    @users = User.all
    render json: @users
  end
  
  # GET /api/v1/users/:id
  def show
    render json: @user
  end
  
  # POST /api/v1/users
  def create
    @user = User.new(user_params)
    
    if @user.save
      render json: { user: @user, message: "User successfully created" }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /api/v1/users/:id
  def update
    if @user.update(user_params)
      render json: { user: @user, message: "User successfully updated" }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /api/v1/users/:id
  def destroy
    @user.destroy
    render json: { message: "User successfully deleted" }
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
  
  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:users).permit(:username, :password)
  end
end
