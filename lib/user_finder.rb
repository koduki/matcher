# -*- encoding: utf-8 -*-
=begin rdoc
質問の回答を検索して返すクラス.
Author:: Hiroaki Nakada
=end
class UserFinder
	#
	# userとstatusに最適な回答を返すメソッド.
	#
	def find user, status
		words = _split_words status
		r = _find user, words 
		unless r == nil || r[:text] == nil 
			{
		  	:status => status, 
			:match => r[:text],
		  	:introduce_to_user => user,
		  	:introduced_by_user => (r != nil) ? r[:user] : nil
			}
		else
			p 'not found ' + status
			{
		  	:status => status, 
			:match => words.join(','),
		  	:introduce_to_user => user,
		  	:introduced_by_user => nil
			}

		end
	end

	def _find user, words
		words.map{|x| Word.find(:all, 
										:conditions => ['text = ? and name <> ?', x, user]).
				  select{|x| x.name != nil} }.
				  flatten.group_by{|x| x.name}.
				  map{|x| 
				  		matches = x[1].map{|y| y.text}
				  		{
					  	:user => x[0], 
					  	:score => x[1].reduce(0){|r, n| r += n.count},
					  	:text => matches.join(',').force_encoding('utf-8')
						}
				  }.sort_by{|x| x[:score]}.first
	end

	def _split_words status
		MA.new.split(status.sub('：',':').split(":")[1..-1].join(":")).
				  select{|x| x["pos"] == "名詞"}.
				  map{|x| x["surface"]}
	end

end
