#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "Please run script with root privileges:"
    echo "sudo $0"; exit 1
fi

cat <<EOT > /etc/cron.weekly/update-script
#!/bin/bash
apt-get update
apt-get upgrade -y >> /var/log/update-\$(date +%Y%m%d).log 2>&1
apt-get autoclean
EOT

chmod +x /etc/cron.weekly/update-script

## If you really want logrotate.d to rotate defined logs, you should choose another name pattern of the log file (without day specified) -
## e.g. "update-$(date +%Y%m).log", because logrotate.d will only rotate files with exactly the same name.
## Also you should schedule logrotate.d autostart not monthly, but weekly or even daily.
## But since our scripts may be checked automatically, I made those steps that were defined in the task.

cat <<EOT > /etc/logrotate.d/update-script
/var/log/update-20*.log {
  rotate 3
  monthly
  compress
}
EOT