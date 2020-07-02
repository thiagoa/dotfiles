local os = require "os"

debug_print("Application: " .. get_application_name())
debug_print("Window: " .. get_window_name());

if (get_application_name() == "emacs") then
   set_window_workspace(3)
   maximize()
end

if (get_application_name() == "app.slack.com_/client") then
   set_window_workspace(1)
end

if (get_application_name() == "discord.com_/app") then
   set_window_workspace(1)
end

if (get_application_name() == "Thunderbird") then
   set_window_workspace(2)
   -- x,y, xsize, ysize
   set_window_geometry(3890,300,1700,1000);
   maximize()
end

if (string.match(get_application_name(), "Google Chrome")) then
   local f = io.popen("wmctrl -l -x | awk '{ print $3 }' | grep google-chrome.Google-chrome | wc -l")

   if (tonumber(f:read("*a")) == 1) then
      set_window_workspace(2)
   end
end

if (get_application_name() == "web.whatsapp.com_/") then
   set_window_workspace(1)
   -- x,y, xsize, ysize
   set_window_geometry(3890,300,1700,1000);
   maximize()
end

if (get_window_name() == "Terminal") then
   set_window_workspace(3)
   -- x,y, xsize, ysize
   set_window_geometry(3890,300,1700,1000);
   maximize()
end
