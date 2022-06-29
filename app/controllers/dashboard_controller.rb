class DashboardController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard/dashboard'

  def index
    @reservations = Reservation.latest
    @contacts = Contact.latest
  end
end
