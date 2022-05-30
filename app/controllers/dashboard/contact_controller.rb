class Dashboard::ContactController < ApplicationController
  def index
    @contacts = Contact.all.order(created_at: 'desc')
  end

  def show
    @contact = Contact.find(params[:id])
  end
end
