# handler.rb
# Abstract base class for all event handlers (Strategy pattern base).
# Subclasses must override `handle` — enforces the contract at runtime.

class Handler
  # Subclasses must implement this method.
  # Raises NotImplementedError if the subclass forgets to override it.
  def handle(event)
    raise NotImplementedError,
          "#{self.class.name} must implement the `handle(event)` method."
  end
end
