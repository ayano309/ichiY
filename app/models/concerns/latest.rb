module Latest
  extend ActiveSupport::Concern

  included do
    scope :latest, -> { where(created_at: 1.week.ago..Time.zone.now).order(created_at: 'desc') }
  end
  
end
