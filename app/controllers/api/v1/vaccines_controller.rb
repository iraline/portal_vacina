# frozen_string_literal: true

module Api
  module V1
    class VaccinesController < ApplicationController
      def index
        vaccines = Vaccine.all
        render json: vaccines
      end

      def show
        vaccine = Vaccine.find(params[:id])
        render json: vaccine
      end

      def create
        vaccine = Vaccine.new(name: params[:name])

        if vaccine.save
          render json: vaccine, status: :created
        else
          render json: vaccine.errors
        end
      end

      def update
        vaccine = Vaccine.find(params[:id])

        if vaccine.update(vaccine_params)
          render json: vaccine, status: :accepted
        else
          render json: vaccine.errors
        end
      end

      private

      def vaccine_params
        params.require(:vaccine).permit(:name)
      end
    end
  end
end
