# frozen_string_literal: true

module Api
    module V1
      class RolesController < ApplicationController
        def index
          roles = Role.all
          render json: roles
        end
  
        def show
          role = Role.find(params[:id])
          render json: role
        end
  
        def create
          role = Role.new(name: params[:name])
  
          if role.save
            render json: role, status: :created
          else
            render json: role.errors
          end
        end
  
        def update
          role = Role.find(params[:id])
  
          if role.update(role_params)
            render json: role, status: :accepted
          else
            render json: role.errors
          end
        end
  
        private
  
        def role_params
          params.require(:role).permit(:name)
        end
      end
    end
  end
  