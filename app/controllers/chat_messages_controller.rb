class ChatMessagesController < ApplicationController
  def create
    if params[:chat_message][:group_id].blank?
      #フォームから受け取った値でチャットルームオブジェクトを取得
      @chat_room = ChatRoom.find(params[:chat_message][:chat_room_id])
      #フォームから受け取った値で、チャットメッセージオブジェクトを作成
      @chat_message = ChatMessage.new(user_id: current_user.id, chat_room_id: @chat_room.id, content: params[:chat_message][:content])
      #保存に成功したら、フラッシュメッセージを表示し、チャットルームへリダイレクトする。
      if @chat_message.save
          # binding.pry
        flash[:notice] = "メッセージの送信に成功しました。"
        redirect_to chat_room_path(@chat_room)
        #保存に失敗した場合は、フラッシュメッセージ表示し、チャットルームへリダイレクトする。
      else
        # binding.pry
        flash[:alert] = "メッセージの送信に失敗しました。"
        redirect_to chat_room_path(@chat_room)
      end
    else
      @group = Group.find(params[:chat_message][:group_id])
      @chat_message = ChatMessage.new(user_id: current_user.id, group_id: @group.id, content: params[:chat_message][:content])
      if @chat_message.save
        # binding.pry
        flash[:notice] = "メッセージの送信に成功しました。"
        redirect_to group_path(@group)
        #保存に失敗した場合は、フラッシュメッセージ表示し、チャットルームへリダイレクトする。
      else
        binding.pry
        flash[:alert] = "メッセージの送信に失敗しました。"
        redirect_to group_path(@group)
      end
    end
  end
end
