module Latest
  extend ActiveSupport::Concern
  #新規一週間の予約orお問い合わせ
  included do
    scope :latest, -> { where(created_at: 1.week.ago..Time.zone.now).order(created_at: 'desc') }
  end
  
end
