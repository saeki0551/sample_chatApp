class MatchingController < ApplicationController
    before_action :authenticate_user!

    def index
        #ログインユーザーに対して「お気に入り！」の評価をしたユーザーのidを配列で取得。
        got_like_users_ids = Like.where(to_user_id: current_user.id, status: 0).pluck(:from_user_id)
        #idが「１」のユーザーがidが「２」、「３」の２人のユーザーから「お気に入り！」の評価を受けている場合の戻り値は以下のようにな配列となります。
        #=>[2,3]

        #上記で取得したユーザーのうち、ログインユーザーからも「お気に入り！」の評価をしたユーザー情報を取得して、ブロックの結果を要素に持つ配列を新たに作成。
        @matching_users=Like.where(to_user_id: got_like_users_ids, from_user_id: current_user.id, status: 0).map do |like|
            like.to_user
        end
        # @user=User.find(current_user.id)
    end
end
