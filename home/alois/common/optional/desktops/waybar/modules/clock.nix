# Clock modules - Time and Date with calendar
# From mechabar: modules/clock.jsonc
_: {
  #-----------------
  # Time
  #-----------------
  # Source: modules/clock.jsonc
  "clock#time" = {
    format = "{:%H:%M}";
    min-length = 5;
    max-length = 5;
    tooltip-format = "<b>Standard Time</b>: <span text_transform='lowercase'>{:%I:%M %p}</span>";
  };

  #-----------------
  # Date with calendar
  #-----------------
  "clock#date" = {
    format = "󰸗 {:%d-%m}";
    min-length = 8;
    max-length = 8;
    tooltip-format = "{calendar}";
    calendar = {
      mode = "month";
      mode-mon-col = 6;
      format = {
        months = "<span alpha='100%'><b>{}</b></span>";
        days = "<span alpha='90%'>{}</span>";
        weekdays = "<span alpha='80%'><i>{}</i></span>";
        today = "<span alpha='100%'><b><u>{}</u></b></span>";
      };
    };
    actions = {
      on-click = "mode";
    };
  };
}
