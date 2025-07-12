class ChatMessagesController < ApplicationController
    def create
        #フォームから受け取った値でチャットルームオブジェクトを取得
        @chat_room=ChatRoom.find(params[:chat_message][:chat_room_id])
        #フォームから受け取った値で、チャットメッセージオブジェクトを作成
        @chat_message=ChatMessage.new(user_id: current_user.id, chat_room_id: @chat_room.id, content: params[:chat_message][:content])
        #保存に成功したら、フラッシュメッセージを表示し、チャットルームへリダイレクトする。
        if @chat_message.save
            flash[:notice]="メッセージの送信に成功しました。"
            redirect_to chat_room_path(@chat_room)
        #保存に失敗した場合は、フラッシュメッセージ表示し、チャットルームへリダイレクトする。
        else
            flash[:alert]="メッセージの送信に失敗しました。"
            redirect_to chat_room_path(@chat_room)
        end
    end
end
