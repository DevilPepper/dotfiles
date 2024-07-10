require 'irb/ext/save-history'

xdg_state = ENV['XDG_STATE_HOME']
if xdg_state.nil? || xdg_state.strip().empty?
    xdg_state = File.expand_path("~/.local/state")
end

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{xdg_state}/history.rb"
