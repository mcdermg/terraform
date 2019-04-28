#db needs to be created for provider to connect
provider "mysql" {
  endpoint = "192.168.0.38:3306"
  username = "sudo mysql"
  password = ""
}

# Create a Database
resource "mysql_database" "app" {
  name = "testing_db"
}
