class Block < ApplicationRecord
  belongs_to :block_user, class_name: 'User', foreign_key: 'block_user_id'
  belongs_to :blocked_user, class_name: 'User', foreign_key: 'blocked_user_id'
end
