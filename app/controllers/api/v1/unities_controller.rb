# frozen_string_literal: true

module Api
    module V1
      class UnitiesController < ApplicationController
        def index
          unities = Unity.all
          render json: unities
        end
  
        def show
          unity = Unity.find(params[:id])
          render json: unity
        end
  
        def create
          unity = Unity.new(name: params[:name])
  
          if unity.save
            render json: unity, status: :created
          else
            render json: unity.errors
          end
        end
  
        def update
          unity = Unity.find(params[:id])
  
          if unity.update(unity_params)
            render json: unity, status: :accepted
          else
            render json: unity.errors
          end
        end
  
        private
  
        def unity_params
          params.require(:unity).permit(:name)
        end
      end
    end
  end
  