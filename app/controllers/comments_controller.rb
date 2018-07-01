class CommentsController < ApplicationController
    before_action :set_topic

    def create
         client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

        comment = @topic.comments.create! comments_params
        comment.user_id = current_user.id
        comment.save!
        
        response = client.create_status("トピック:#{@topic.title}に新しいコメントがつきました！")

        redirect_to @topic
    end

    private
        def set_topic
            @topic = Topic.find(params[:topic_id])
        end

        def comments_params
            params.required(:comment).permit(:body)
        end
end