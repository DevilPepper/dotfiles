# Copied from here: https://unix.stackexchange.com/a/704612
import os
import atexit
import readline
from datetime import datetime

history = os.path.join(
    (
        os.environ.get('XDG_STATE_HOME') or
        os.path.expanduser('~/.local/state')
    ),
    'python_history.py'
)

try:
    readline.read_history_file(history)
except FileNotFoundError:
    readline.add_history(f'# History created at {datetime.now().isoformat()}')
except OSError as e:
    raise OSError(f'{history} cannot be a directory') from e

def write_history():
    try:
        readline.write_history_file(history)
    except OSError:
        pass

atexit.register(write_history)
