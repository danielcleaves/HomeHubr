class DashboardsController < ApplicationController
before_action :authenticate_user!

	def index
		@houses = current_user.houses
	end
end