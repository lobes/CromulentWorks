# Local development
default:
    dotnet watch run --launch-profile CromulentWorks

# Build and publish
publish:
    dotnet publish -c Release

# Deploy to production
deploy: publish
    rsync -avz --delete bin/Release/net8.0/publish/* root@172.236.35.106:/var/www/cromulentworks/
    ssh root@172.236.35.106 "systemctl restart cromulentworks"

# Check status of production services
status:
    ssh root@172.236.35.106 "systemctl status cromulentworks && systemctl status caddy"

# View production logs
logs:
    ssh root@172.236.35.106 "journalctl -u cromulentworks -n 100 -f"

# View Caddy logs
caddy-logs:
    ssh root@172.236.35.106 "journalctl -u caddy -n 100 -f"