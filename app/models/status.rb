class Status < ActiveRecord::Base
	def message
		@message.force_encoding('utf-8') if @message
	end

	def to_user_name
		@to_user_name.force_encoding('utf-8') if @to_user_name
	end
end
