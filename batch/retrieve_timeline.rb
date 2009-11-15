# -*- encoding: utf-8 -*-

require "twitter"
def post status, finder, generator, user
	r = finder.find(status.user.screen_name, status.text)
	puts "foud : #{r}"
				
	msg = generator.generate r
	puts "post messge :#{msg}"
	
	unless msg == nil
		post = Post.new.post(msg, status.twitter_id, user)
		puts = "Tweet about the status \n #{post}"

		# 発言内容を保存.
		Match.new(post).save unless post == nil
		puts "Saves this matching result."
	else
		puts "No Message to #{status.text}"
	end
end

begin
	config_file_path = File.expand_path( File.join(File.dirname(__FILE__),
			"..", "config",  "twitter.yml"))
	msg = "Load configurations of twitter client from #{config_file_path}. "
	puts msg
	
	client = Twitter::Client.from_config(config_file_path, 'scrape')
	msg = "Client loaded successfully." 
	puts msg
	
rescue => e
	msg = "retrieve_timeline.rb caught exception: " + e.to_s + 
				"\n " + e.backtrace.join("\n ")
	puts msg
end

#タイムラインの取得
timeline = client.timeline_for(:friends, :count => 200).select{|status| !Status.exists?(:twitter_id => status.id) }
puts "get #{timeline.size} tweets."

timeline.each do |status|
	begin
		until Status.exists? :twitter_id => status.id
			# DBに保存していなければ，ステータスを保存
			Status.new(
				:message => status.text,
				:twitter_id => status.id,
				:to_status_id => status.in_reply_to_status_id,
				:to_user_name => status.user.screen_name
			).save

			# 発言トリガを含んでいるか判定 
			if status.text =~ /^\s*ギブミー:/ or status.text =~ /^\s*ギブミー：/
				# ユーザを検索
				puts 'find with user'
				post status, UserFinder.new, MessageGeneratorWithUser.new, 'user'
				# 発言を検索
				puts 'find with tweet'
				post status, TweetFinder.new, MessageGeneratorWithTweet.new, 'tweet'
			end
		end
	rescue => e
		msg = "retrieve_timeline caught exception: " + e.to_s +
					"\n " + e.backtrace.join("\n ")
		puts msg
	end

end


