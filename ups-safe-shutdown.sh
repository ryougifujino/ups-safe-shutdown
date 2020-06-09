#!/bin/sh

target_ip=192.168.2.66
failure_count=0
shutdown_failure_count_threshold=10

while :
do
  ping -c 1 -w 5 $target_ip &> /dev/null
  if [ $? -eq 0 ]; then
    ((failure_count=0))
    echo 1
  else
    ((failure_count++))
    echo 2
  fi
  sleep 20s
  if [ $failure_count -eq $shutdown_failure_count_threshold ]; then
    shutdown -hP now
    break
  fi
done