class LikesController < ApplicationController
    def create
        likes = Like.find_or_initialize_by(to_user_id: params[:user_id], from_user_id: current_user.id) #from_user : 誰からの評価なのかを判別するためのカラム、to_user : 誰に対しての評価なのかを判別するためのカラム
        likes.update(status: params[:reaction])
        redirect_to("/users/#{params[:user_id]}")
    end
end
