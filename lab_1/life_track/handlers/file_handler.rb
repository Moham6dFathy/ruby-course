# handlers/file_handler.rb
# Strategy: appends the formatted event line to `life_track.log`.
# No console output, no stats tracking — single responsibility.

require_relative '../handler'

LOG_FILE = 'life_track.log'.freeze

class FileHandler < Handler
  # Appends: [YYYY-MM-DD HH:MM] TYPE — description (N min)
  def handle(event)
    File.open(LOG_FILE, 'a') do |file|
      file.puts format_line(event)
    end
  end

  private

  def format_line(event)
    time_str = event.timestamp.strftime('%Y-%m-%d %H:%M')
    "[#{time_str}] #{event.type.upcase} — #{event.description} (#{event.duration} min)"
  end
end
