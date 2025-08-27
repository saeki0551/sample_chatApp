class BlocksController < ApplicationController
  def create
    blocked_user_id = User.find(params[:id])
    # binding.pry
    @block = Block.new(block_user_id: current_user.id,  blocked_user_id: blocked_user_id.id)
    @block.save
    redirect_to user_path(blocked_user_id.id)
  end 

  def destroy
    blocked_user_id = User.find(params[:id])
    @block = Block.find_by(blocked_user_id: blocked_user_id.id)
    @block.destroy
    redirect_to user_path(blocked_user_id.id)
  end

  private

  def block_params
    block_user_id = current_user.id
    blocked_user_id = User.find(params[:id])
    blocked_user_id = blocked_user_id.id
    params.require(:block).permit(:block_user_id, :blocked_user_id)
    binding.pry
  end
end
