# frozen_string_literal: true

module Api
  module V1
    class LocalitiesController < ApplicationController
      def index
        localities = Locality.all
        render json: localities
      end

      def show
        locality = Locality.find(params[:id])
        render json: locality
      end

      def create
        locality = Locality.new(state_id: params[:state_id], city_id: params[:city_id])

        if locality.save
          render json: locality, status: :created
        else
          render json: locality.errors
        end
      end

      def update
        locality = Locality.find(params[:id])

        if locality.update(locality_params)
          render json: locality, status: :accepted
        else
          render json: locality.errors
        end
      end

      private

      def locality_params
        params.require(:locality).permit(:state_id, :city_id)
      end
    end
  end
end
