class CommentsController < ApplicationController
  def index
    @photo = Photo.find(params[:photo_id])
    @comments = @photo.comments
    @comment = Comment.new
  end

  def create
    @photo = Photo.find(params[:photo_id])
    @comments = @photo.comments
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.photo = @photo

    respond_to do |format|
      if @comment.save
        format.html { redirect_to photo_comments_url(@photo), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else # Validation errors
        format.html { render :index }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:photo_id, :user_id, :content)
    end
end
