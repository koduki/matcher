# -*- encoding: utf-8 -*-
class MessageGeneratorWithUser
	def generate params
		return nil if params == nil

		status, match, to_user, from_user = 
			params[:status], params[:match],params[:introduce_to_user], params[:introduced_by_user]
		
		msg = _generate status, match, to_user, from_user

		params[:message] = msg
		params[:user_status] = params[:status]

		params.delete(:status)
		params.delete(:match)
		params
	end

	def _generate status, match, to_user, from_user
		unless from_user == nil
			# Generetes a message
			".@#{to_user} #{match}と言えば @#{from_user} が詳しいと思うよ, RT @#{to_user} : #{status}"
		else
			".@#{to_user} #{match}と言えばGoogle先生が詳しいよ! RT @#{to_user} : #{status}"
		end
	end
end
