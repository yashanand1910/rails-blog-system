class ArticlesController < ApplicationController
    before_filter :require_login, except: [:new, :index, :show]

    include ArticlesHelper

    def require_login
        unless logged_in?
            flash.notice = "You must login first."
            redirect_to new_author_session_path
            return false
        end
    end

    def index
        @articles = Article.all
    end
    def show
        @article = Article.find(params[:id])
        @comment = Comment.new
        @comment.article_id = @article.id
    end
    def new
        @article = Article.new
    end
    def create
        @article = Article.new(article_params)
        @article.save
        flash.notice = "Article '#{@article.title}' created."
        redirect_to article_path(@article)
    end
    def destroy
        @article = Article.find(params[:id])
        @article.taggings.each do |tagging|
            tagging.destroy
        end
        @article.comments.each do |comment|
            comment.destroy
        end
        @article.destroy
        flash.notice = "Article '#{@article.title}' deleted."
        redirect_to articles_path
    end
    def edit
        @article = Article.find(params[:id])
    end
    def update
        @article = Article.find(params[:id])
        @article.update(article_params)
        flash.notice = "Article '#{@article.title}' updated."
        redirect_to article_path(@article)
    end
end