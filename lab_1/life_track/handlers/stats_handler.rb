# handlers/stats_handler.rb
# Strategy: accumulates in-memory statistics per event type.
# Does NOT print during dispatch — only prints a summary on program exit via at_exit.
# The menu loop never calls `summary` directly (SRP + spec constraint).

require_relative '../handler'

class StatsHandler < Handler
  def initialize
    @counts  = Hash.new(0)   # event_type => count
    @minutes = Hash.new(0)   # event_type => total minutes

    # Automatically print the summary when the Ruby process exits.
    # This fires whether the user chooses "Exit" or presses Ctrl-C.
    this = self
    at_exit { this.summary }
  end

  # Silently accumulates data — prints nothing.
  def handle(event)
    @counts[event.type]  += 1
    @minutes[event.type] += event.duration
  end

  # Prints a formatted stats table.
  # Called automatically by at_exit — never called from the menu loop.
  def summary
    puts
    puts '─' * 44
    puts '  LifeTrack Session Summary'
    puts '─' * 44
    puts format('  %-12s %8s %12s', 'Type', 'Sessions', 'Total (min)')
    puts '─' * 44

    if @counts.empty?
      puts '  No events logged this session.'
    else
      @counts.each_key do |type|
        puts format('  %-12s %8d %12d', type.to_s.capitalize, @counts[type], @minutes[type])
      end
    end

    puts '─' * 44
  end
end
