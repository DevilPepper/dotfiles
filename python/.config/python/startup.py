# Copied from here: https://unix.stackexchange.com/a/704612
import os
import atexit
import readline
import sys
from datetime import datetime

sys.ps1 = "\001\033[32m\002\001\033[0m\002 "
sys.ps2 = "├   "

if sys.version_info[0] <= 3 and sys.version_info[1] <= 12:
  history = os.path.join(
      (
          os.environ.get('XDG_STATE_HOME') or
          os.path.expanduser('~/.local/state')
      ),
      'history.py'
  )

  try:
      readline.read_history_file(history)
  except FileNotFoundError:
      readline.add_history(f'# History created at {datetime.now().isoformat()}')
  except OSError as e:
      raise OSError(f'{history} cannot be a directory') from e

  @atexit.register
  def write_history():
      try:
          readline.write_history_file(history)
      except OSError:
          pass
