#!/bin/bash

################################################################################################
# A shell script for monitoring the various meneory consumption of a java processes
# including the RSS, process memory map, the heap dump and the native memory usage. 
# Author: srinivas1996kumar@gmail.com
################################################################################################

while true
do
  pid=$(ps -aux | grep "<your_java_process>.jar" | awk '$0  !~ /grep/  {print $2}')
  timestamp=$(date "+%Y.%m.%d-%H.%M.%S")
  hpd_filename=hpd${pid}___${timestamp}.hprof
  nm_filename=nm${pid}___${timestamp}.txt
  pmap_filename=pm${pid}___${timestamp}.txt
  rss_filename=rss${pid}___${timestamp}.txt
  jmap -dump:live,format=b,file=tmp/$hpd_filename $pid
  jcmd $pid VM.native_memory detail > tmp/$nm_filename
  pmap -x $pid  > tmp/$pmap_filename
  ps -p  $pid  -o pcpu -o rss > tmp/$rss_filename
  sleep 1800
done