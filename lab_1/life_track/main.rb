# main.rb
# Entry point — wires everything together and runs the menu loop.
#
# To add a new handler:
#   1. Create handlers/<new_handler>.rb
#   2. Add one `require_relative` + one `router.register(...)` line below.
# Nothing else in this file (or any other file) needs to change.

require_relative 'life_event'
require_relative 'event_router'
require_relative 'handlers/console_handler'
require_relative 'handlers/file_handler'
require_relative 'handlers/stats_handler'

# ── Wire up the router ──────────────────────────────────────────────────────
router = EventRouter.new
router.register(ConsoleHandler.new)
router.register(FileHandler.new)
router.register(StatsHandler.new)   # summary fires automatically at_exit

# ── Menu helpers ─────────────────────────────────────────────────────────────
MENU_OPTIONS = {
  '1' => :work,
  '2' => :study,
  '3' => :exercise,
  '4' => :meal
}.freeze

def print_menu
  puts
  puts '=== LifeTrack ==='
  puts '1. Log a work session'
  puts '2. Log a study session'
  puts '3. Log an exercise session'
  puts '4. Log a meal'
  puts '5. Exit'
  print 'Choose an option: '
end

def prompt(label)
  print "#{label}: "
  $stdin.gets.to_s.chomp
end

# ── Main loop ────────────────────────────────────────────────────────────────
loop do
  print_menu
  choice = $stdin.gets.to_s.chomp

  break if choice == '5'

  event_type = MENU_OPTIONS[choice]

  unless event_type
    puts '⚠  Invalid option. Please choose 1–5.'
    next
  end

  description = prompt('Description')
  raw_duration = prompt('Duration (minutes)')

  duration = raw_duration.to_i
  if duration <= 0
    puts '⚠  Duration must be a positive integer.'
    next
  end

  event = LifeEvent.new(type: event_type, description: description, duration: duration)
  router.dispatch(event)
  puts '✓ Event logged.'
end
