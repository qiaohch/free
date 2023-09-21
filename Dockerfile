# Specifies that the latest microsoft/iis image will be used as the base image
# Used to specify which base container image will be used by the build process.

# Notice that the naming convention is "**owner/application name : tag name**"
# (shown as microsoft/iis:latest); so in our case the owner of the image is
# Microsoft and the application is IIS with the "latest" tag name being used
# to specify that you will pull the most recent image version available.
FROM microsoft/iis:latest

# Copies contents of the wwwroot folder to the inetpub/wwwroot folder in the new container image
# Used to specify that you want to copy the WWWroot folder to the IIS inetpub WWWroot
# folder in the container. You don't have to specify the full path to your local
# files because docker already has the logic built-in to reference files and folders
# relative to the docker file location on your system. Also, make note that that
# docker will only recognize forward slashes for file paths - since this is a
# Windows based container instead of Linux.
COPY wwwroot c:/inetpub/wwwroot

# Run some PowerShell commands within the new container to set up the image

# Run the PowerShell commands to remove the default IIS files and create a new
# application pool called TestPool
RUN powershell Remove-Item c:/inetpub/wwwroot/iisstart.htm -force
RUN powershell Remove-Item c:/inetpub/wwwroot/iisstart.png -force
RUN powershell Import-Module WebAdministration
RUN powershell New-WebAppPool -Name 'TestPool'

# Exposes port 80 on the new container image
# Used to open TCP port 80 for allowing an http connection to the website.
# However, this line is commented out, because the IIS container has this port
# already open by default.
#EXPOSE 80

# Sets the main command of the container image
# This tells the image to run a service monitor for the w3svc service.
# When this is specified the container will automatically stop running
# if the w3svc service stopped. This line is commented out because of the
# IIS container already has this entrypoint in place by default.
#ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]
