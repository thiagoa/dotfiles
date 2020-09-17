debug_print("Application: " .. get_application_name())
debug_print("Window: " .. get_window_name())

function number_of_windows(app)
   local number_of_windows = io.popen("wmctrl -l -x | awk '{ print $3 }' | grep " .. app .. " | wc -l")
   return tonumber(number_of_windows:read("*a"))
end

if (get_application_name() == "emacs") then
   set_window_workspace(3)
   maximize()
   focus()
end

if (get_application_name() == "app.slack.com_/client") then
   set_window_workspace(1)
   focus()
end

if (get_application_name() == "discord.com_/app") then
   set_window_workspace(1)
   focus()
end

if (get_application_name() == "Thunderbird") then
   -- Rule should not apply to prompts, which have WM_CLASS = Prompt.Thunderbird
   if (number_of_windows("Thunderbird") == 1) then
      set_window_workspace(2)
      -- x,y, xsize, ysize
      set_window_geometry(3890,300,1700,1000);
      focus()
   end
end

if (string.match(get_application_name(), "Google Chrome")) then
   if (number_of_windows("google-chrome.Google-chrome") == 1) then
      set_window_workspace(2)
      focus()
   end
end

if (get_application_name() == "web.whatsapp.com_/") then
   set_window_workspace(1)
   -- x,y, xsize, ysize
   set_window_geometry(3890,300,1700,1000);
   focus()
end

if (get_window_name() == "Terminal") then
   set_window_workspace(3)
   -- x,y, xsize, ysize
   set_window_geometry(3890,300,1700,1000);
   maximize()
   focus()
end

if (get_application_name() == "win0") then
   set_window_workspace(4)
   maximize()
   focus()
end
