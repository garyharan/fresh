#!/bin/bash
osascript <<'END'
tell application "iTerm"
  activate

  set cmds to {"rails s", "yarn build --watch", "rails tailwindcss:watch", "ngrok http --url=meet-vertically-sturgeon.ngrok-free.app 3000"}

  if (count of windows) = 0 then
    set win to (create window with default profile)
  else
    set win to current window
  end if

  repeat with i from 1 to count of cmds
    set cmd to item i of cmds

    set newTab to (create tab with default profile in win)
    set newSession to current session of newTab

    tell newSession
      -- Set the tab title
      write text "echo -ne \"\\033]0;" & cmd & "\\007\""
      -- Run the command
      write text cmd
    end tell
  end repeat
end tell
END
