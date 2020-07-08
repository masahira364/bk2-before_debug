class SearchController < ApplicationController
	def search
		@user_or_book = params[:model]
		@how_search = params[:how]
		@search = params[:search]
		if @user_or_book == "1"
			@users = User.search(params[:search], @user_or_book, @how_search)
		else
			@books = Book.search(params[:search], @user_or_book, @how_search)
		end
	  end

end
