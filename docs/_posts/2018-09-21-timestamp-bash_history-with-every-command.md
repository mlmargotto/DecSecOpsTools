---
layout: post
title: Timestamp bash_history with every command
excerpt: "Customize your bash_history..."
modified: 2018-09-21
tags: [Linux]
comments: false
category: blog
---

When working on Linux it is often very helpful to review the commands that you have entered. For example, you may want to paste some of the commands into a script or may want to recreate the steps to solve the problem you were working on.

Here is how I do it:

```
## Modify History for Current Session
# Add Timestamp to .bash_history
HISTTIMEFORMAT="%d/%m/%y %T "
# Write Current History to .bash_history
history -a
# Update .bash_history with every command
export PROMPT_COMMAND='history -a'

## Add to .bash_profile to make changes permanent
echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> $HOME/.bashrc
echo "export PROMPT_COMMAND='history -a'" >> $HOME/.bashrc

## Save the last 10,000 lines to disk and keep 5000 lines in memory
cat $HOME/.bashrc | sed 's/#\?\(HISTSIZE\s*=\s*\).*$/\15000/' | \
    sed 's/#\?\(HISTFILESIZE\s*=\s*\).*$/\110000/' > temp.txt
mv -f temp.txt $HOME/.bashrc
source ~/.bashrc
```

See also [https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps](https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps)

**NOTE:** if you want to display the recent history without timestamps, just use `fc -ln`
