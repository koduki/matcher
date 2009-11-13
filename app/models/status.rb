class Status < ActiveRecord::Base
	def message
		s = self['message']
		s.force_encoding('utf-8') if s
	end

	def to_user_name
		s = self['to_user_name']
		s.force_encoding('utf-8') if s
	end
end
