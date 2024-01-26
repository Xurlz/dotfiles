#!/usr/bin/env bash

function main()
{
  if [ -x /usr/bin/rclone ]; then
    rclone mount `getEnterprisePath` ~/notes-enterprise/
  else
    echo '  rclone program has not been found. It need to be installed.'
    echo '    try `sudo apt update && sudo apt install rclone` '
    return 1
  fi
}

function getEnterprisePath()
{
  if [ -n "$RCLONE_ENTERPRISE_NOTES_PATH" ]; then
    echo $RCLONE_ENTERPRISE_NOTES_PATH
  else
    echo '  `$RCLONE_ENTERPRISE_NOTES_PATH` variable is not set'
    return 1
  fi
  return 0
}

function getMountPath()
{
  if [ -n "$ENTERPRISE_NOTES_MOUNT_PATH" ]; then
    echo $ENTERPRISE_NOTES_MOUNT_PATH
  else
    echo '  `$ENTERPRISE_NOTES_MOUNT_PATH` variable is not set'
    return 1
  fi
  return 0
}

echo `getMountPath`
echo `getEnterprisePath`
# main

