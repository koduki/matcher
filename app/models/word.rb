class Word < ActiveRecord::Base
	def text
		s = self['text']
		s.force_encoding('utf-8') if s
	end

end
