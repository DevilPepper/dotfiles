function fish-eval
    eval $(cat $argv | sed 's/^.*=/set -x &/' | sed 's/=/ /' | sed 's/;.*$//')
end

if status is-login
    if test -z "$SSH_AUTH_SOCK"
        # Check for a currently running instance of the agent
        set RUNNING_AGENT $(ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]')
        set SSH_AGENT_SCRIPT "$HOME/.ssh/ssh-agent"
        if [ "$RUNNING_AGENT" = "0" ]
            # Launch a new instance of the agent and add existing keys
            ssh-agent -s > $SSH_AGENT_SCRIPT
            fish-eval $SSH_AGENT_SCRIPT
            for key in $(ls ~/.ssh/*.pub)
                # Removes .pub extension
                ssh-add (string split --right --max 1 . $key)[1]
            end
        else
            fish-eval $SSH_AGENT_SCRIPT
        end
    end
end
