# frozen_string_literal: true

module Api
  module V1
    class PeopleController < ApplicationController
      def index
        people = Person.all
        render json: people
      end

      def show
        person = Person.find(params[:id])
        render json: person
      end

      def create
        person = Person.new(person_params)

        if person.save
          render json: person, status: :created
        else
          render json: person.errors
        end
      end

      def update
        person = Person.find(params[:id])

        if person.update(person_params)
          render json: person, status: :accepted
        else
          render json: person.errors
        end
      end

      private

      def person_params
        params.require(:person).permit(:name, :born_at, :locality_id, :cpf)
      end
    end
  end
end
