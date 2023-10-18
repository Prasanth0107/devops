#!/bin/bash

# Set your email address to receive notifications
email="your_email@example.com"

# Name of the service to monitor (httpd for Apache)
service_name="httpd"

# Check if the service is running
if systemctl is-active --quiet $service_name; then
    echo "Service $service_name is running."
else
    echo "Service $service_name is not running. Attempting to start..."
    systemctl start $service_name

    # Check if the service has started successfully
    if systemctl is-active --quiet $service_name; then
        echo "Service $service_name started successfully."
    else
        echo "Failed to start $service_name."
        
        # Send an email notification
        echo "Service $service_name is not running and could not be started." | mail -s "Service Monitor Alert" $email
    fi
fi
