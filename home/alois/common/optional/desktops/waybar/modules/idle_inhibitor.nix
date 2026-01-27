# Idle inhibitor module
# From mechabar: modules/idle_inhibitor.jsonc
_:
let
  # Mechabar exact icons:
  # 󰈈 = U+F0208 (nf-md-eye)
  # 󰈉 = U+F0209 (nf-md-eye_off)
  eyeOpen = builtins.fromJSON ''"\uDB80\uDE08"'';
  eyeClosed = builtins.fromJSON ''"\uDB80\uDE09"'';
in
{
  idle_inhibitor = {
    format = "{icon}";
    format-icons = {
      activated = eyeOpen;
      deactivated = eyeClosed;
    };
    min-length = 3;
    max-length = 3;
    tooltip-format-activated = "<b>Idle Inhibitor</b>: Activated";
    tooltip-format-deactivated = "<b>Idle Inhibitor</b>: Deactivated";
    start-activated = false;
  };
}
