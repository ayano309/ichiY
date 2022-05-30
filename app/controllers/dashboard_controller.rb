class DashboardController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard/dashboard'

  def index
    @reservations = Reservation.all.order(created_at: 'desc')
    @contacts = Contact.all.order(created_at: 'desc')
  end
  
end
