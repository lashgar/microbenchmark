#!/bin/bash
GPUARCH=-arch=sm_35
nthread=$2
iter=$1

nvcc ./obj/openacc.o $GPUARCH -o ./obj/snmerger$iter ./src/${iter}loads_per_thread.cu -DDISP=$3 -DNTHD=$nthread -I ./include/
line=
for (( i=0; i<3; i++ ))
do
 time=`nvprof --metrics ipc_instance,gld_transactions,gst_transactions,stall_inst_fetch,stall_exec_dependency,stall_sync,stall_data_request,inst_executed,stall_other,warp_execution_efficiency,ldst_fu_utilization,l2_utilization,dram_utilization,sysmem_utilization,cf_fu_utilization,alu_fu_utilization ./obj/snmerger$iter 2> ./log/.profile.nmerger6.$nthread.$iter.$3.$i.txt`
 echo "$nthread ($i) -> $time"
 line="$line${time}\t"
done
echo -en ${nthread}"\t"$line"\n" >> ./log/data_${3}merged_${iter}loads.spc

