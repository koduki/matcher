# -*- encoding: utf-8 -*-
require 'twitter'

class FollowNewFollowers
	attr_accessor :client

	def get_timeline user
		client.timeline_for(:user, :id => user.screen_name, :count => 200).
		select{|status| !Status.exists?(:twitter_id => status.id) }.
		map do |status|
			puts "#{user.screen_name} said #{status.text}"
			Status.new(:twitter_id => status.id,
						  :message => status.text,
		 				  :to_status_id => status.in_reply_to_status_id,
  	  					  :to_user_name => status.user.screen_name).
					save
		end		
	
	end

	def auto_follow
		followers = client.my(:followers)
		followers.select{|follower| !follower.following }.map{|u|
			begin
				client.friend :add, u.screen_name
				puts "add user success #{u.screen_name}."
				u
			rescue
				puts "add user fail #{u.screen_name}."
				nil
			end
		}.select{|x| x != nil}
		.map{|u|
			User.new(:twitter_id => u.id, 
						:screen_name => u.screen_name,
					   :profile_image_url => u.profile_image_url)			
				.save
			u
		}
	end

	def auto_remove
		followings = User.find(:all).map{|u|u.screen_name}
		followers = client.my(:followers).map{|u|u.screen_name}
		(followings - followers).to_set.map{|u| 
			begin
				puts "remove #{u}"
				client.friend(:remove, u)
				User.find_by_screen_name(u).delete
			rescue
				puts 'ここを通ったらDBのデータが変です.'	
			end
		} 
	end

	def run
		new_followers = auto_follow
		new_followers.map{|u| get_timeline u} 

		auto_remove
	end

	def initialize client = nil
		puts "initializing for executing this batch."
		
		@client = if(client == nil) 
						Twitter::Client.from_config(
								  File.join(File.dirname(__FILE__),
												"..", "config", "twitter.yml"), 
								'scrape')
					else
						client
					end
	end
end

batch = FollowNewFollowers.new
batch.run
