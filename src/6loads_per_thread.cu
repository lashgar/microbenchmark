#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <openacc.h>
#define IPMACC_MAX1(A)   (A)
#define IPMACC_MAX2(A,B) (A>B?A:B)
#define IPMACC_MAX3(A,B,C) (A>B?(A>C?A:(B>C?B:C)):(B>C?C:B))
#include <cuda.h>

__global__ void __generated_kernel_region_0(int chunk,int* dummy2,int* dummy1,int nthread,long long unsigned int* time);

int main()
{
    int i, j, k; int nthread = NTHD, iteration = 6, chunk = 128 / sizeof(int); 
//    int dummy1 [(nthread) * chunk * iteration * 2], dummy2 [(nthread) * chunk * iteration * 2]; long long unsigned int time [nthread];
    int *dummy1=(int*)malloc((nthread) * chunk * iteration * 2*sizeof(int));
    int *dummy2=(int*)malloc((nthread) * chunk * iteration * 2*sizeof(int));
    long long unsigned int *time=(long long unsigned int*)malloc(nthread*sizeof(long long unsigned int));


    ipmacc_prompt((char*)"IPMACC: memory allocation dummy2\n");
    acc_create((void*)dummy2,( nthread ) *  chunk  *  iteration  *  2*sizeof(int));
    ipmacc_prompt((char*)"IPMACC: memory allocation dummy1\n");
    acc_create((void*)dummy1,( nthread ) *  chunk  *  iteration  *  2*sizeof(int));
    ipmacc_prompt((char*)"IPMACC: memory allocation time\n");
    acc_create((void*)time,nthread*sizeof(long long unsigned int));
    ipmacc_prompt((char*)"IPMACC: memory copyin dummy2\n");
    acc_copyin((void*)dummy2,( nthread ) *  chunk  *  iteration  *  2*sizeof(int));
    ipmacc_prompt((char*)"IPMACC: memory copyin dummy1\n");
    acc_copyin((void*)dummy1,( nthread ) *  chunk  *  iteration  *  2*sizeof(int));
    ipmacc_prompt((char*)"IPMACC: memory copyin time\n");
    acc_copyin((void*)time,nthread*sizeof(long long unsigned int));


    {





        /* kernel call statement [0, -1]*/
        if (getenv("IPMACC_VERBOSE")) printf("IPMACC: Launching kernel 0 > gridDim: %d\tblockDim: %d\n",(((abs((int)((nthread))-0))/(1)))/512+1,512);
        //__generated_kernel_region_0<<<(((abs((int)((nthread))-0))/(1)))/512+1,512>>>(
        __generated_kernel_region_0<<<1,nthread>>>(
                chunk,
                (int*)acc_deviceptr((void*)dummy2),
                (int*)acc_deviceptr((void*)dummy1),
                nthread,
                (long long unsigned int*)acc_deviceptr((void*)time));
        /* kernel call statement*/
        if (getenv("IPMACC_VERBOSE")) printf("IPMACC: Synchronizing the region with host\n");
        cudaDeviceSynchronize();



    }
    ipmacc_prompt((char*)"IPMACC: memory copyout dummy2\n");
    acc_copyout_and_keep((void*)dummy2,( nthread ) *  chunk  *  iteration  *  2*sizeof(int));
    ipmacc_prompt((char*)"IPMACC: memory copyout dummy1\n");
    acc_copyout_and_keep((void*)dummy1,( nthread ) *  chunk  *  iteration  *  2*sizeof(int));
    ipmacc_prompt((char*)"IPMACC: memory copyout time\n");
    acc_copyout_and_keep((void*)time,nthread*sizeof(long long unsigned int));



    for (i = 0; i < nthread; i += 32) {
        printf("%llu	", time [i]);
    }
    for (; i < 512; i += 32) {
        printf("%llu	", 0);
    }
    return 0;
}


__device__ int __smc_select_0_dummy1(int index, int down, int up, int* g_array, int* s_array, int vector_size, int pivot, int before){
    // the pragmas are well-set. do not check the boundaries.
    return s_array[index-(vector_size*blockIdx.x)+before-pivot];
}

__device__ void __smc_write_0_dummy1(int index, int down, int up, int* g_array, int* s_array, int vector_size, int pivot, int before,int value){
    // the pragmas are well-set. do not check the boundaries.
    s_array[index-(vector_size*blockIdx.x)+before-pivot]=value;
}
__global__ void __generated_kernel_region_0(int chunk,int* dummy2,int* dummy1,int nthread,long long unsigned int* time){
    int __kernel_getuid=threadIdx.x+blockIdx.x*blockDim.x;
    int i;

    /* declare the shared memory of dummy1 */
    //__shared__ int __kernel_smc_var_data_dummy1[512+1+1];
    //__shared__ unsigned char __kernel_smc_var_tag_dummy1[512+1+1];
    __shared__ int __kernel_smc_var_data_dummy1[1024+1+1];
    __shared__ unsigned char __kernel_smc_var_tag_dummy1[1024+1+1];
    {
        int iterator_of_smc=0;
        for(iterator_of_smc=threadIdx.x; iterator_of_smc<(512+1+1); iterator_of_smc+=blockDim.x){
            __kernel_smc_var_data_dummy1[iterator_of_smc]=0;
            __kernel_smc_var_tag_dummy1[iterator_of_smc]=0;
        }
        __syncthreads();
    }
    {
        {
            {
                i=0+(__kernel_getuid);
                if( i < nthread)
                { // opened for smc fetch
                    { // fetch begins
                        int kk;
                        __syncthreads();
                        for(int kk=threadIdx.x; kk<(512+1+1); kk+=blockDim.x)
                        {
                            int idx=blockIdx.x*512+kk-1+0;
                            if(idx<(nthread) && idx>=(0))
                            {
                                __kernel_smc_var_data_dummy1[kk]=dummy1[idx];
                                __kernel_smc_var_tag_dummy1[kk]=1;
                            }
                        }
                        __syncthreads();
                    } // end of fetch
#define dummy1(index) __smc_select_0_dummy1(index, (blockIdx.x*512)-(1), ((blockIdx.x+1)*512)+(1), dummy1, __kernel_smc_var_data_dummy1, 512, 0, 1)


                    {
                        if (i < nthread) {
                            long long unsigned int tick, tock; unsigned long long int d1 = threadIdx.x / 32; unsigned long long int d2 = threadIdx.x / (DISP * 32); unsigned long long int addr1 = (unsigned long long int)dummy2 + ((threadIdx.x) + 32 * (d2 - d1) + ((blockDim.x / DISP) * 1)) * chunk * sizeof(int);
                            unsigned long long int addr2 = (unsigned long long int)dummy2 + ((threadIdx.x) + 32 * (d2 - d1) + ((blockDim.x / DISP) * 2)) * chunk * sizeof(int);
                            unsigned long long int addr3 = (unsigned long long int)dummy2 + ((threadIdx.x) + 32 * (d2 - d1) + ((blockDim.x / DISP) * 3)) * chunk * sizeof(int);
                            unsigned long long int addr4 = (unsigned long long int)dummy2 + ((threadIdx.x) + 32 * (d2 - d1) + ((blockDim.x / DISP) * 4)) * chunk * sizeof(int);
                            unsigned long long int addr5 = (unsigned long long int)dummy2 + ((threadIdx.x) + 32 * (d2 - d1) + ((blockDim.x / DISP) * 5)) * chunk * sizeof(int);
                            unsigned long long int addr6 = (unsigned long long int)dummy2 + ((threadIdx.x) + 32 * (d2 - d1) + ((blockDim.x / DISP) * 6)) * chunk * sizeof(int);
                            __syncthreads();
                            __smc_write_0_dummy1(i, (blockIdx.x*512)-(1), ((blockIdx.x+1)*512)+(1), dummy1, __kernel_smc_var_data_dummy1, 512, 0, 1, addr1 + addr2 + addr3 + addr4 + addr5 + addr6 + 0);
                            __syncthreads();
                            __syncthreads();
                            tick = clock();
                            int reg1; asm ("ld.global.s32 %0, [%1+0];" : "=r" (reg1) : "l" (addr1));
                            int reg2; asm ("ld.global.s32 %0, [%1+0];" : "=r" (reg2) : "l" (addr2));
                            int reg3; asm ("ld.global.s32 %0, [%1+0];" : "=r" (reg3) : "l" (addr3));
                            int reg4; asm ("ld.global.s32 %0, [%1+0];" : "=r" (reg4) : "l" (addr4));
                            int reg5; asm ("ld.global.s32 %0, [%1+0];" : "=r" (reg5) : "l" (addr5));
                            int reg6; asm ("ld.global.s32 %0, [%1+0];" : "=r" (reg6) : "l" (addr6));
                            reg1 = reg1 + reg2 + reg3 + reg4 + reg5 + reg6 + 0;
                            __syncthreads();
                            tock = clock();
                            __syncthreads();
                            __smc_write_0_dummy1(0, (blockIdx.x*512)-(1), ((blockIdx.x+1)*512)+(1), dummy1, __kernel_smc_var_data_dummy1, 512, 0, 1, reg1 + dummy1 (0));
                            __syncthreads();
                            time [i] = (tock - tick);
                        }
                    }
                    { // writeback begins
                        int kk;
                        __syncthreads();
                        for(int kk=threadIdx.x; kk<(512+1+1); kk+=blockDim.x)
                        {
                            int idx=blockIdx.x*512+kk-1+0;
                            if(idx<(nthread) && idx>=(0))
                            {
                                dummy1[idx]=__kernel_smc_var_data_dummy1[kk];
                            }
                        }
                        __syncthreads();
                    } // end of writeback

#undef dummy1

                } // closed for smc fetch end

            }
        }
    }
}

