# Enable UPower for battery and lid state monitoring
{ ... }:
{
  services.upower = {
    enable = true;
    # Laptop-specific power management
    criticalPowerAction = "Hibernate";
  };
}
