# Custom module: Dividers (powerline separators)
# Adapted from mechabar: modules/custom/dividers.jsonc
let
  # Standard Powerline characters (non-rounded)
  # These create the "arrow" effect between modules
  #
  # U+E0B0  = right-pointing powerline arrow (used for right_div in mechabar)
  # U+E0B2  = left-pointing powerline arrow (used for left_div in mechabar)
  #
  # In mechabar style:
  # - left_div: uses U+E0B2 (left-pointing arrow, creates "cut-in" from left)
  # - right_div: uses U+E0B0 (right-pointing arrow, creates "cut-in" from right)
  # - left_inv/right_inv: swapped versions for the center distro icon effect

  # Mechabar uses:  for left_div,  for right_div
  divLeft = builtins.fromJSON ''"\ue0b2"''; # - left-pointing
  divRight = builtins.fromJSON ''"\ue0b0"''; # - right-pointing
in
{
  #-----------------
  # Left dividers - use left-pointing arrow (matches mechabar)
  #-----------------
  "custom/left_div#1" = {
    format = divLeft;
    tooltip = false;
  };
  "custom/left_div#2" = {
    format = divLeft;
    tooltip = false;
  };
  "custom/left_div#3" = {
    format = divLeft;
    tooltip = false;
  };
  "custom/left_div#4" = {
    format = divLeft;
    tooltip = false;
  };
  "custom/left_div#5" = {
    format = divLeft;
    tooltip = false;
  };
  "custom/left_div#6" = {
    format = divLeft;
    tooltip = false;
  };
  "custom/left_div#7" = {
    format = divLeft;
    tooltip = false;
  };
  "custom/left_div#8" = {
    format = divLeft;
    tooltip = false;
  };

  # Left inverse - use left-pointing arrow (points toward center)
  "custom/left_inv#1" = {
    format = divLeft;
    tooltip = false;
  };
  "custom/left_inv#2" = {
    format = divLeft;
    tooltip = false;
  };

  #------------------
  # Right dividers - use right-pointing arrow (matches mechabar)
  #------------------
  "custom/right_div#1" = {
    format = divRight;
    tooltip = false;
  };
  "custom/right_div#2" = {
    format = divRight;
    tooltip = false;
  };
  "custom/right_div#3" = {
    format = divRight;
    tooltip = false;
  };
  "custom/right_div#4" = {
    format = divRight;
    tooltip = false;
  };
  "custom/right_div#5" = {
    format = divRight;
    tooltip = false;
  };

  # Right inverse - use right-pointing arrow (points away from center)
  "custom/right_inv#1" = {
    format = divRight;
    tooltip = false;
  };
}
