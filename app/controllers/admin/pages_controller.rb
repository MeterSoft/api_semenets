class Admin::PagesController < ApplicationController
  def index
    @pages = get_request('/api/pages', current_user, 'get')
  end

  def new
  end

  def create
  	data = current_user.merge({ page: params[:page] })
  	@page = get_request('/api/pages', data, 'post')

  	if @page['error'].present?
  	  flash.now[:error] = @page['error']
  	  index
  	else
  	  flash.now[:success] = 'Page was created'
  	  index
  	end
  end

  def published
    @pages = get_request('/api/pages/published', current_user, 'get')
  end

  def unpublished
    @pages = get_request('/api/pages/unpublished', current_user, 'get')
  end

  def publish
  	@page = get_request("/api/pages/#{params['id']}/published", current_user, 'post')

  	if @page['error'].present?
  	  flash.now[:error] = @page['error']
  	  index
  	else
  	  flash.now[:success] = 'Page was publish'
  	  index
  	end
  end

  def destroy
  	@page = get_request("/api/pages/#{params['id']}", current_user, 'delete')

  	if @page['error'].present?
  	  flash.now[:error] = @page['error']
  	  index
  	else
  	  flash.now[:success] = 'Page was deleted'
  	  index
  	end
  end

  def edit
  	@page = get_request("/api/pages/#{params['id']}", current_user, 'get')
  end

  def update
  	data = current_user.merge({ page: params[:page] })
  	@page = get_request("/api/pages/#{params['id']}", data, 'put')

  	if @page['error'].present?
  	  flash.now[:error] = @page['error']
  	  index
  	else
  	  flash.now[:success] = 'Page was update'
  	  index
  	end
  end

  def show
  	@page = get_request("/api/pages/#{params['id']}", current_user, 'get')
  	@count = get_request("/api/pages/#{params['id']}/total_words", current_user, 'get')

  	if @page['error'].present? || @count['error'].present?
  	  flash.now[:error] = @page['error'] || @count['error']
  	  index
  	else
  	  index
  	end
  end
end
