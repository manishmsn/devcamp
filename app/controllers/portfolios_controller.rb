class PortfoliosController < ApplicationController

	layout 'portfolio'

	before_action :set_portfolio_item, only: [:edit, :update, :show, :destroy]
	access all: [:show, :index, :angular], user: {except: [:destroy, :new, :create, :update, :edit]}, site_admin: :all

	def index
		@portfolio_items = Portfolio.all
	end

	def angular
		@angular_portfolio_items = Portfolio.angular
	end

	def new
		@portfolio_item = Portfolio.new
		3.times{ @portfolio_item.technologies.build }
	end

	def create
		@portfolio_item = Portfolio.new(portfolio_params)
		if @portfolio_item.save
			redirect_to portfolios_path
		else
			render :new
		end
	end

	def edit
		#@portfolio_item = Portfolio.find(params[:id])
		#3.times{ @portfolio_item.technologies.build }
	end

	def update
		#@portfolio_item = Portfolio.find(params[:id])
		if @portfolio_item.update(portfolio_params)
			redirect_to portfolios_path
		end
	end

	def show
		#@portfolio_item = Portfolio.find(params[:id])
	end

	def destroy
		#@portfolio_item = Portfolio.find(params[:id])
		@portfolio_item.destroy
		redirect_to portfolios_url
	end

	private

	def portfolio_params
		params.require(:portfolio).permit(:title, 
																			:subtitle, 
																			:body, 
																			:main_image, 
																			:thumb_image,
																			technologies_attributes: [:name]
		)
	end

	def set_portfolio_item
		@portfolio_item = Portfolio.find(params[:id])
	end
end
