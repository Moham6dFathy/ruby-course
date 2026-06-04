# handlers/console_handler.rb
# Strategy: prints a formatted event line to the terminal (stdout only).
# No file I/O, no stats tracking — single responsibility.

require_relative '../handler'

class ConsoleHandler < Handler
  # Prints: [YYYY-MM-DD HH:MM] TYPE — description (N min)
  def handle(event)
    puts format_line(event)
  end

  private

  def format_line(event)
    time_str = event.timestamp.strftime('%Y-%m-%d %H:%M')
    "[#{time_str}] #{event.type.upcase} — #{event.description} (#{event.duration} min)"
  end
end
