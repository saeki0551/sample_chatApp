class UsersController < ApplicationController
    def index
        @user=User.find(current_user.id)
        @users=User.all
    end

    def show
        @user = User.find(params[:id])
        @like = Like.find_by(to_user_id: @user.id, from_user_id: current_user.id)
    end
end
