#!/bin/bash
## cpu核数
cpu_core_num=( $(python -c 'import multiprocessing; print(multiprocessing.cpu_count())' ))

# 启动进程梳理 = 2 * cpu_core_num + 1
pro_num=$(expr $cpu_core_num \* 2 + 1)
th_num=4
port=5000


gunicorn chat:app -w $pro_num -b :$port --thread $th_num -t 300 -D