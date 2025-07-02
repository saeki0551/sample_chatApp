class LikesController < ApplicationController
    def create
        likes=Like.find_or_initialize_by(to_user_id: params[:user_id], from_user_id: current_user.id)
        likes.update(status: params[:reaction])
        if params[:reaction] == "like" 
            flash[:reaction]="素敵！！！"
        else
            flash[:reaction]="微妙。。。"   
        end
        redirect_to("/users/#{params[:user_id]}")
    end
end
