class GroupsController < ApplicationController
     before_action :set_group, only: [:edit, :update]

    def index
        @group_lists = Group.all
        @group_joining = GroupUser.where(user_id: current_user.id)
        @group_lists_none = "グループに参加していません。"
        # Railsで配列をActive Record Relationに変換したい 配列をUserオブジェクトとして扱いたい
        #paramsは文字列で取得するので、オブジェクトは取得できない
        @matching_users = User.find(params[:id])
        # @matching_users = User.where(id: params[:matching_users])
        # binding.pry
    end

    def new
        @group = Group.new
        # @group.users << current_user
        @matching_users = User.find(params[:id])

    end
    
    def create
        @group = Group.new(group_params)
        if @group.save
            redirect_to groups_url, notice: 'グループを作成しました。'
        else
            render :new
        end
    end

    def show
        @group = Group.find(params[:id])
    end

    def edit
        @group = Group.find(params[:id])
    end

    def update
        @group = Group.find(params[:id])
        if @group.update(group_params)
            redirect_to groups_path, notice: 'グループを更新しました。'
        else
            render :edit
        end
    end

    def destroy
        delete_group = Group.find(params[:id])
        if delete_group.destroy
            redirect_to groups_path, notice: 'グループを削除しました。'
        end
    end
    
    private
        def set_group
            @group = Group.find(params[:id])
        end

        def group_params
            params.require(:group).permit(:name, user_ids: [])
        end
end
