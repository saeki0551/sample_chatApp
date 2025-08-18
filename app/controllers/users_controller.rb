class UsersController < ApplicationController
    def index
        @user=User.find(current_user.id)
        @users=User.all
    end

    def show
        @user = User.find(params[:id])
        @like = Like.find_by(to_user_id: @user.id, from_user_id: current_user.id)

        blocked_user_id = User.find(params[:id])
        @block = Block.find_by(blocked_user_id: blocked_user_id.id)

        block_user_id = User.find(params[:id])
        @blocked = Block.where(block_user_id: block_user_id.id, blocked_user_id: current_user.id)
    end
end
