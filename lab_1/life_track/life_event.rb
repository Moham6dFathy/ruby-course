# life_event.rb
# Data class — carries event information only.
# No display or storage logic lives here (SRP).

class LifeEvent
  VALID_TYPES = %i[work study exercise meal].freeze

  attr_reader :type, :description, :duration, :timestamp

  def initialize(type:, description:, duration:)
    unless VALID_TYPES.include?(type)
      raise ArgumentError, "Invalid event type: #{type}. Must be one of #{VALID_TYPES.join(', ')}"
    end

    @type        = type
    @description = description
    @duration    = duration
    @timestamp   = Time.now
  end
end
