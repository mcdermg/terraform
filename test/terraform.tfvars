profile = "terraform"

ami = "ami-04cf61cbbfe8b423a"

instance_type = "t2.micro"

key_name = "terraform"

#user_data      =" <<-EOF #!/bin/bash DD_API_KEY=97846e3ec0199f171bf9d80a61f1dea6 bash -c '$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)' EOF"
user_data = ""
