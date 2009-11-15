class Match < ActiveRecord::Base
	def post_status
		s = self['post_status']
		s.force_encoding('utf-8') if s
	end

	def user_status
		s = self['user_status']
		s.force_encoding('utf-8') if s
	end

end
