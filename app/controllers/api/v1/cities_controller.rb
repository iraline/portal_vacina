# frozen_string_literal: true

module Api
  module V1
    class CitiesController < ApplicationController
      def index
        cities = City.all
        render json: cities
      end

      def show
        city = City.find(params[:id])
        render json: city
      end

      def create
        city = City.new(name: params[:name])

        if city.save
          render json: city, status: :created
        else
          render json: city.errors
        end
      end

      def update
        city = City.find(params[:id])

        if city.update(city_params)
          render json: city, status: :accepted
        else
          render json: city.errors
        end
      end

      private

      def city_params
        params.require(:city).permit(:name)
      end
    end
  end
end
