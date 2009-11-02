# -*- encoding: utf-8 -*-
=begin rdoc
Matcherにおいて，Twitterでつぶやくための機能を提供するクラス．
特定のシンボルをキーとしたハッシュを引数としてpostメソッドを与えることで，
つぶやく．
Author:: Tatsuya Sato
=end
require 'twitter'

class Post
	# 
	# 引数はシンボルをキーとしたハッシュで与える．キーとして使えるシンボルは下記のつ．
	# +introduce_to_user:: Matcherに紹介されるユーザ．Twitter::Userまたはスクリーンネームを表すStringオブジェクトを与えること．
	# +status+:: Matcherに紹介される
	# 
	def post status, env='test'
		# The bot tweets
		config_file_path = File.join(File.dirname(__FILE__), "..", "config",  "twitter.yml")
	  	puts config_file_path

		client = Twitter::Client.from_config(config_file_path, env)
		post_status = client.status(:post, status[:message])
		status[:twitter_id] = post_status.id
		status[:post_status] = post_status.text
		status.delete(:message)
		status
	end
end
