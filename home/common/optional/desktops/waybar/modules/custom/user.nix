# Custom module: User group (trigger + username)
# Adapted from mechabar: modules/custom/user.jsonc
{
  #-----------------
  # User group
  #-----------------
  "group/user" = {
    orientation = "horizontal";
    modules = [
      "custom/trigger"
      "custom/user"
    ];
    drawer = { };
  };

  "custom/trigger" = {
    format = "󰍜";
    min-length = 4;
    max-length = 4;
    tooltip = false;
  };

  "custom/user" = {
    exec = "id -un";
    format = "{}";
    tooltip = false;
  };
}
