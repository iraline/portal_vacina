# frozen_string_literal: true

module Api
    module V1
      class ShotsController < ApplicationController
        def index
          shots = Shot.all
          render json: shots
        end
  
        def show
          shot = Shot.find(params[:id])
          render json: shot
        end
  
        def create
          shot = Shot.new(shot_params)
  
          if shot.save
            render json: shot, status: :created
          else
            render json: shot.errors
          end
        end

        private
  
        def shot_params
          params.require(:shot).permit(:person_id, :locality_id,:vaccine_id,:unity_id,:shot_at)
        end
      end
    end
  end
  