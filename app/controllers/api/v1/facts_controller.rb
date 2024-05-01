class Api::V1::FactsController < ApplicationController
    before_action :set_user
    before_action :set_fact, only: [:show, :update, :destroy]
  
    # GET /api/v1/users/:user_id/facts
    def index
      @facts = @user.facts
      render json: @facts
    end
  
    # GET /api/v1/users/:user_id/facts/:id
    def show
      render json: @fact
    end
  
    # POST /api/v1/users/:user_id/facts
    def create
      @fact = @user.facts.new(fact_params)
  
      if @fact.save
        render json: @fact, status: :created
      else
        render json: @fact.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/facts/:id
    def update
      if @fact.update(fact_params)
        render json: @fact
      else
        render json: @fact.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/facts/:id
    def destroy
      @fact.destroy
      render json: {message:"Fact Successfully Deleted!"}
      head :no_content
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:user_id])
      end
  
      def set_fact
        # debugger
        @fact = @user.facts.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def fact_params
        params.require(:facts).permit(:content,:fact, :likes, :user_id)
      end
  end
  