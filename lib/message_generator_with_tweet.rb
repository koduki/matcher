# -*- encoding: utf-8 -*-
class MessageGeneratorWithTweet
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
			".@#{from_user} が前に「#{match}」って言ってたから聞いてみたら？, RT @#{to_user}: #{status}"
		else
			nil
		end
	end
end
