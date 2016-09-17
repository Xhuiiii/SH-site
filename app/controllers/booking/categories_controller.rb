require_dependency "booking/application_controller"

module Booking
  class CategoriesController < ApplicationController
  	before_action :set_category, only: [:show, :edit, :update, :destroy]

  	def new
  		@category = Category.new
  	end

  	def create
  		@category = Category.new(category_params)

  		if @category.save
  			redirect_to @category, notice: "Category was successfully created."
  		else
  			render :new
  		end
  	end

  	def destroy
  		@category.destroy
  		redirect_to categories_url, notice: "Category was successfully destroyed."
  	end

  	def update
  		if @category.update(category_params)
  			redirect_to @category, notice: "Category was successfully updated."
  		else
  			render :edit
  		end
  	end

  	def index
  		@categories = Category.all
  	end

  	def show
  		@category = Category.find(params[:id])
  	end

  	private

  	# Use callbacks to share common setup or constraints between actions.
  	def set_category
    	@category = Category.find(params[:id])
  	end
  	# Only allow a trusted parameter "white list" through.
    def category_params
    	params.require(:category).permit(:name, :multiple_day)
    end
  end
end