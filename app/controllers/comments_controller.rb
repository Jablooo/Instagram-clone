class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_photo


  def index
    @photo = Photo.find(params[:photo_id])
    @comments = @photo.comments
    @comment = Comment.new
  end

  def show
  end

  def edit
  end

  def create
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments
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

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to photo_comments_url(@photo), notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_photo
     @photo = Photo.find(params[:photo_id])
    end

    def comment_params
      params.require(:comment).permit(:photo_id, :user_id, :content)
    end
end
