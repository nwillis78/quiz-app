class LinksController < ApplicationController
	def create
		@link = Link.new(link_params)
        
        @link.save
	end
end
