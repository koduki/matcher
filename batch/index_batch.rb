# -*- encoding: utf-8 -*-
class IndexBatch
	def indexingRawWord
		index = Status.find(:all).
				  			select{|x| RawWord.find_by_twitter_id(x.twitter_id) == nil}.
							select{|x| x.to_user_name != nil and
									   x.to_user_name != 'ume_bot' and
									   x.to_user_name != 'sakura_bot' and
										User.find_by_screen_name(x.to_user_name) and
										((x.message =~ /^ギブミー/) != 0)	
							}.map{|x| 
				  				begin
				  					[x.to_user_name, MA.new.split(x.message), x.twitter_id]
								rescue
									nil
								end
							}.select{|x| x != nil}.
							map{|xs|
								xs[1].map{|x| 
								x["twitter_id"] = xs[2]
								x["user_name"] = xs[0]
								x
							}
					}.flatten
		len = 0	
		index.each do |x| 
			RawWord.new(x).save 
			len += 1
		end
		len
	end

	def indexingWord
		Word.delete_all
		user_posts = Status.find(:all, 
										 :select => "count(*) count, to_user_name", 
										 :group=>"to_user_name").
				  	map{|x|[x.to_user_name, x.count]}.
				  	inject({}){|hs,elm| 
				  		hs[elm[0]] = elm[1].to_f
				  		hs
					}

		index = RawWord.find(:all, 
									:select => "count(id) count, user_name, surface",
									:group=>"user_name, surface", 
									:conditions=>["pos=?","名詞"]).
							map{|x| {:name => x.user_name, 
									   :text => x.surface, 
#										:count => (x.count.to_f / user_posts[x.user_name]) * 100000000}}
										:count => (x.count.to_f / (user_posts[x.user_name].to_f) * 1000000 )}}
		len = 0
		index.each{|x| 
			Word.new(x).save 
			len += 1
		}
		len
	end

	def run
		puts "start indexing raw data."
		size1 = indexingRawWord
		puts "index size #{size1.to_s}."

		puts "indexing word count data."
		size2 = indexingWord
		puts "index size #{size2.to_s}."
	end

end

batch = IndexBatch.new
batch.run
