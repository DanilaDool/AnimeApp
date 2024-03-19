class User < ApplicationRecord
  def online?
    return false if last_seen_at.nil?
    last_seen_at >= 5.minutes.ago
  end

end
