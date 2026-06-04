# event_router.rb
# Observer pattern: notifies all registered handlers when an event is dispatched.
#
# SOLID compliance:
#   - Depends ONLY on the abstract Handler interface (DIP).
#   - Never references ConsoleHandler, FileHandler, or StatsHandler by name (OCP/DIP).
#   - Contains zero menu logic (SRP).

require_relative 'handler'

class EventRouter
  def initialize
    @handlers = []
  end

  # Registers any Handler subclass.
  def register(handler)
    unless handler.is_a?(Handler)
      raise ArgumentError, "#{handler.class.name} must be a subclass of Handler."
    end

    @handlers << handler
  end

  # Dispatches an event to every registered handler.
  def dispatch(event)
    @handlers.each { |handler| handler.handle(event) }
  end
end
