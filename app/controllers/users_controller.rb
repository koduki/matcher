class UsersController < ApplicationController
	def index
		 @user = params[:name]
		 @matches = Match.find( :all, 
										:conditions=>['introduced_by_user = ?', @user])
		 					.sort_by{|x| x.created_at}.reverse

		 @scope = count2rank Word.find(:all, 
								  :conditions=>['name = ?', @user])
		 					.sort_by{|x| x.count}
							.reverse
							.take(50)
	end
	
	def count2rank xs
		tmp = xs.first
		size = xs.length
		xs.map do |x| 
			if x != tmp
				tmp = x
				size -= 1
			end
			x.count = size
			x
		end
	end	  
end
