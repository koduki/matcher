# -*- encoding: utf-8 -*-
class MatchesController < ApplicationController
  # GET /matches
  # GET /matches.xml
  def index
	 @news = Match.find(:all).group_by{|x| x.user_status_id}.map{|x| x[1]}.
				reverse[0..4]
	 @intro_rank = rank('introduced_by_user')
	 @hot_giveme = hot_giveme

	 respond_to do |format|
      format.html # index.html.erb
    end
  end

  def hot_giveme
	 Match.find(:all)
	 	.group_by{|x| x.user_status.sub('：', ':')}
		.sort_by{|x| x[1].size * -1}
		.map{|x|
			{
				:text => x[0][5..-1],
				:size => x[1].size * 2 + 10 
			}
		}
  end

  def rank column
	 Match.find(:all, 
				  :select => "count(*) count, " + column, 
				  :group=> column)
	 		.map{|x| {
				  :name => (x[column]) ? x[column] : 'Google先生', 
				  :count => x.count.to_i 
					}
			}.sort_by{|x| x[:count]}
			.reverse
  end

  # GET /matches/1
  # GET /matches/1.xml
  def show
    @match = Match.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @match }
    end
  end

end
