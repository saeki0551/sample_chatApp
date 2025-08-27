class ChatRoomsController < ApplicationController
     def index
     end
     
     def create
        #ログインユーザーの所属するチャットルームを全件配列で取得。
        current_users_chat_rooms = ChatRoomUser.where(user_id: current_user.id).map do |chat_room_user| 
            chat_room_user.chat_room   
        end
        # パラメーターで与えられたuser_idのユーザーとログインユーザーが所属するチャットルームを配列で取得し、インデックスで要素を取り出す。
        chat_room = ChatRoomUser.find_by(chat_room_id: current_users_chat_rooms, user_id: params[:user_id])
        #条件に合うチャットルームが存在しない場合は、チャットルームを新規作成。
        if chat_room.blank? 
            chat_room = ChatRoom.create
            ChatRoomUser.create(user_id: current_user.id, chat_room_id: chat_room.id)
            ChatRoomUser.create(user_id: params[:user_id], chat_room_id: chat_room.id)  
        end
        #chat_rooms/show.html.erbへ遷移
        redirect_to chat_room_path(chat_room.chat_room_id)
    end

    def show
        #フォームに渡すために、モデルのインスタンスを作成。
        @chat_message = ChatMessage.new
        #受け取ったクエリパラメータでチャットルームオブジェクトを取得。
        @chat_room = ChatRoom.find(params[:id])
        #表示するチャットルーム内でのメッセージを全件配列で取得。
        @chat_messages = ChatMessage.where(chat_room_id: @chat_room.id)
        #チャット相手ユーザーの取得。
        @chat_room_user = @chat_room.chat_room_users.where.not(user_id: current_user.id).pluck(:user_id)
        @chat_room_user = User.find_by(id: @chat_room_user) #findかfind_byかwhereか
        @blocked_user = Block.where(block_user_id: @chat_room_user.id, blocked_user_id: current_user).pluck(:blocked_user_id)
        @blocked_user = User.find_by(id: @blocked_user)
        # binding.pry
    end
end
