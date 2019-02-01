# Terraform Variables
# Customize parameters in this file specific to your deployment.
# Current & new passwords can be supplied here, but safer to supply variables inline when applying config:
# terraform apply -var 'password=PASSWORD' -var 'new_password=NEWPASS'

# CONNECTION PARAMETERS
raspberrypi_ip = "192.168.1.75"
username = "pi"
password = "raspberry"

# CONIGURATION PARAMETERS
new_hostname = "raspberrypi_brenda"
new_password = "chefVancouver866"
# Validate timezone correctness against 'timedatectl list-timezones'
timezone = "America/Vancouver"

# NETWORK CONFIGURATION PARAMETERS
# See man dhcpcd.conf for further info and examples.
# Get these right or risk loss of network connectivity.
# static_ip_and_mask = "192.168.1.75/24"
# static_router = "192.168.1.254"
# check this and above to confirm
# static_dns = "192.168.1.1"
