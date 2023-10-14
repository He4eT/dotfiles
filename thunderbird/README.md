# Thunderbird

- Place `userChrome.css` in `~/.thunderbird/[random letters and numbers].default/chrome/`.
- Set *Thunderbird Start Page* to `file:///home/odd/dotfiles/thunderbird/newTab.html`.
- Set `tbkeys-lite` bindings on the extension preferences page.

## tbkeys-lite Bindings

```json
{
    "j": "cmd:cmd_nextMsg",
    "k": "cmd:cmd_previousMsg",
    "shift+k": "unset",
    "o": "cmd:cmd_openMessage",
    "f": "cmd:cmd_forward",
    "#": "cmd:cmd_delete",
    "r": "cmd:cmd_reply",
    "R": "cmd:cmd_replyall",
    "a": "cmd:cmd_archive",
    "c": "func:MsgNewMessage",
    "u": "tbkeys:closeMessageAndRefresh",
    "q": "cmd:cmd_goStartPage",
    "b": "unset",
    "m": "cmd:cmd_markAsUnread",
    "shift+m": "cmd:cmd_markAsRead",
    "p": "unset",
    "s": "unset",
    "t": "unset",
    "w": "unset",
    "x": "unset",
    "]": "unset",
    "[": "unset"
}
```
