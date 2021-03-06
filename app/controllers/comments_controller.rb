class CommentsController < ApplicationController
  load_and_authorize_resource
  
  # POST /comments
  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    @comment.user = current_user
    @user = current_user
    respond_to do |format|
      if @comment.save
        # ActionCable.server.broadcast 'product_channel', comment: @comment, average_rating: @comment.product.average_rating
        logger.debug "** About to execute ProductChannel command #{@product.id}**"
        # ProductChannel.broadcast_to @product.id, comment: CommentsController.render(partial: 'comments/comment', locals: {comment: @comment, current_user: current_user}), average_rating: @product.average_rating

        format.html { redirect_to @product, notice: 'Review was created successfully.', id: "notice" }
        format.json { render :show, status: :created, location: @product }
        format.js 
      else
        format.html { redirect_to @product, alert: 'Review was not saved successfully.', id: "notice" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = Comment.find(params[:id])
    product = @comment.product
    @comment.destroy
    redirect_to product
  end

private
  def comment_params
    params.require(:comment).permit(:user_id, :body, :rating)
  end

end