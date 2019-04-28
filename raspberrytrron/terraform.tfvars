# Current & new passwords can be supplied here, but safer to supply variables inline when applying config:
# terraform apply -var 'password=PASSWORD' -var 'new_password=NEWPASS'

# CONNECTION PARAMETERS
raspberrypi_ip = ["192.168.0.35", "192.168.0.36", "192.168.0.37", "192.168.0.38"]
username = "pi"
password = "chefVancouver866"

# CONIGURATION PARAMETERS
# Validate timezone correctness against 'timedatectl list-timezones'
timezone = "America/Vancouver"
