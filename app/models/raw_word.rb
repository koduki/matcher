class RawWord < ActiveRecord::Base
	def surface
		@surface.force_encoding('utf-8') if @surface
	end

end
