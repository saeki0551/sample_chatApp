class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]

  def index
    @group_lists = Group.all
    @group_joining = GroupUser.where(user_id: current_user.id)
    @group_lists_none = "グループに参加していません。"
    # Railsで配列をActive Record Relationに変換したい 配列をUserオブジェクトとして扱いたい
    #paramsは文字列で取得するので、オブジェクトは取得できない
    # @matching_users = User.find(params[:id])

    # binding.pry
  end

  def new
    @group = Group.new
    # @group.users << current_user
    # @matching_users = User.find(params[:id])
    got_like_users_ids = Like.where(to_user_id: current_user.id, status: 0).pluck(:from_user_id)    
    @matching_users = Like.where(to_user_id: got_like_users_ids, from_user_id: current_user.id, status: 0).map do |like|
    like.to_user
    end  
  end
    
    def create
      @group = Group.new(create_group_params)
    #   binding.pry
      if @group.save
        redirect_to groups_path
      else
        render :new
      end
    end

    def show
        @group = Group.find(params[:id])
        @group_users = GroupUser.where(group_id: @group.id)
        # binding.pry
        @chat_message = ChatMessage.new
        @chat_messages = ChatMessage.where(group: @group)
    end

    def edit
      @group = Group.find(params[:id])
    end

    
    def update
      @group = Group.find(params[:id])
      if @group.update(edit_group_params)
        redirect_to groups_path, notice: 'グループを更新しました。'
      else
        render :edit
      end
    end
      

    def editInvite
      @group = Group.find(params[:id])
      @group_users = GroupUser.where(group_id: @group.id)
      @group_user_ids = @group_users.pluck(:user_id)
      @invite_group_users = User.where.not(id: @group_user_ids)
    end

    def editInviteUpdate
      @group = Group.find(params[:group][:id])
      # binding.pry #edit_group_paramsと打って、値を見る
      if @group.update(edit_invite_group_params)
        redirect_to groups_path, notice: 'グループを更新しました。'
      else
        render :edit
      end
    end

    def editDestroy
      @group = Group.find(params[:id])
      @group_users = GroupUser.where(group_id: @group.id)
      @group_user_ids = @group_users.pluck(:user_id)
      @destroy_group_users = User.where(id: @group_user_ids) 
      # binding.pry
    end

    def editDestroyUpdate
      @group = Group.find(params[:group][:id])
      if @group.update(edit_destroy_group_params)
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

        def create_group_params
          group_user_ids = params[:group][:user_ids]
          group_user_ids.push(current_user.id)
          params.require(:group).permit(:name, user_ids: []).merge(user_ids: group_user_ids)
        end

        def edit_group_params
          params.require(:group).permit(:name)
        end

        def edit_invite_group_params
          invite_group_users = User.where(id: params[:group][:user_ids]).pluck(:id)

          group = Group.find(params[:group][:id])
          group_user_ids = GroupUser.where(group_id: group.id)
          group_user_ids = group_user_ids.pluck(:user_id)
          group_user_ids = User.where(id: group_user_ids).pluck(:id)

          group_user_ids.concat(invite_group_users)
          # binding.pry
          params.require(:group).permit(user_ids: []).merge(user_ids: group_user_ids)
        end

        def edit_destroy_group_params
          destroy_group_users = User.where(id: params[:group][:user_ids]).pluck(:id)

          group = Group.find(params[:group][:id])
          group_user_ids = GroupUser.where(group_id: group.id)
          group_user_ids = group_user_ids.pluck(:user_id)
          group_user_ids = User.where(id: group_user_ids).pluck(:id)

          group_user_ids = group_user_ids - destroy_group_users
          # binding.pry
          params.require(:group).permit(user_ids: []).merge(user_ids: group_user_ids)
        end
end
