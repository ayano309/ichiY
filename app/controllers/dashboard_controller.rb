class DashboardController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard/dashboard'

  def index
    @reservations = Reservation.where(created_at: 1.week.ago..Time.zone.today).order(created_at: 'desc')
    @contacts = Contact.where(created_at: 1.week.ago..Time.zone.today).order(created_at: 'desc')
  end
  
end
