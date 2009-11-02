# -*- encoding: utf-8 -*-
=begin rdoc
発言ベースで質問の回答を検索して返すクラス.
Author:: Hiroaki Nakada
=end
class TweetFinder
	#
	# userとstatusに最適な回答を返すメソッド.
	#
	def find user, status
		words = _split_words status
		r = _find user, words 
		unless r.first == 0 
print "find :"
p r 
			{
		  	:status => status, 
 			:match => r.last.message,
		  	:introduce_to_user => user,
		  	:introduced_by_user => (r != nil) ? r.last.to_user_name : nil
			}
			
		else
			p 'not found ' + status
			nil
		end
	end
	
	def _split_words status
		MA.new.split(status.sub('：', ':').split(":")[1..-1].join(":")).select{|x| x["pos"] == "名詞"}.map{|x| x["surface"]}
	end

	def _find user, words
		index = _index user
		rank = _rank index, words
		[rank.first[1], Status.find_by_twitter_id(rank.first[0])]

		#rank[0,5].map{|x| [x[1], Status.find_by_twitter_id(x[0])] }.map{|x| [x[0], x[1].message.force_encoding('utf-8')] }
	end

	def _rank index, words
		index.map{|status| 
			 	count = status.last.to_set.
						  map{|w| words.to_set.any?{|x| x == w}}.
						  count(true)
				score = (count < (words.size * 0.7).round ) ? 0 : ((count * 1.0 / words.to_set.size) * 100).to_i
			  	[status.first, score]
			 }.sort_by{|x| x.last}.reverse
	end

	def _index user
		RawWord.find(:all,
						 :select => "twitter_id, surface", 
						 :conditions=>["pos=? and user_name <> ?",  '名詞', user]).
			  		group_by{|x| x.twitter_id}.
					map{|x| [x.first, x.last.map{|y| y.surface}]}
	end
end
