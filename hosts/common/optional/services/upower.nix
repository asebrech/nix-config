# Enable UPower for battery and lid state monitoring
# Required by hyprdynamicmonitors for lid state detection
{ ... }:
{
  services.upower = {
    enable = true;
    # Laptop-specific power management
    criticalPowerAction = "Hibernate";
  };
}
