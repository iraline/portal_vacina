# frozen_string_literal: true

module Api
  module V1
    class StatesController < ApplicationController
      def index
        states = State.all
        render json: states
      end

      def show
        state = State.find(params[:id])
        render json: state
      end

      def create
        state = State.new(name: params[:name])

        if state.save
          render json: state, status: :created
        else
          render json: state.errors
        end
      end

      def update
        state = State.find(params[:id])

        if state.update(state_params)
          render json: state, status: :accepted
        else
          render json: state.errors
        end
      end

      private

      def state_params
        params.require(:state).permit(:name)
      end
    end
  end
end
