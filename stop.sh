#!/bin/bash
ps aux |grep 'gunicorn chat:app' | grep -v 'grep' | grep -v PPID |  awk '{print $2}'|xargs kill -9

#PROC_NAME="gunicorn chat:app"
#echo "pid_kill进程名：$PROC_NAME"
#ProcNumber=`ps -ef |grep -w $PROC_NAME|grep -v grep|wc -l`
#echo "进程数量：$ProcNumber"
#if [ $ProcNumber -le 0 ];then
#   echo "$PROC_NAME is not run"
#else
#   echo "$PROC_NAME is  running.."
#   echo "ps -ef | grep $PROC_NAME |grep -v 'grep'| awk '{print $2}' |while read pid; do kill -9 $pid; done"
#   ps -ef | grep $PROC_NAME |grep -v 'grep'| awk '{print $2}' |while read pid; do kill -9 $pid; done
#fi