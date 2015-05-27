
# THIS PARAMETERS SPECIFY THE LAYOUT OF THE INPUT FILE
# configure the number of warps
n_warps = 16
# configure the number of samples 
n_samples = 3



from optparse import OptionParser

parser = OptionParser()
parser.add_option("-f", "--file", dest="filename",
                  help="Path to .spc log file", metavar="FILE", default="")
(options, args) = parser.parse_args()

if options.filename=="":
    parser.print_help()
    exit(-1)
else:
    print '\twarning: storing the overal latency and variance in <'+options.filename+'.csv>)'

# GENERAL MATH
def hmean(numbers):
    sum = 0.0
    for n in numbers:
        sum += 1.0/n
    return len(numbers)/sum
def avg(numbers):
    sum = 0.0
    for n in numbers:
        sum += n
    return sum/len(numbers)
def var(numbers):
    a = avg(numbers)
    sum = 0.0
    for n in numbers:
        sum += (n-a)*(n-a)
    return sum/(len(numbers)-1)

#files = []
#for i in [1, 2, 3]:
#    for j in [1, 2, 4, 8, 16, 32]:
#        files.append('org/data_nmerger6-'+str(j)+'_'+str(i)+'.csv')

files=[options.filename]

for f in files:
    lines = open(f).readlines()
    data_xthd=[]
    data_ylat=[]
    data_yvar=[]
    for l in lines:
        thd = l.split()[0]
        samples = []
        while len(samples)<n_samples:
            # print len(samples), str(samples), len(l.split()), 1+n_warps*len(samples)
            try:
                samples.append(int(l.split()[1+n_warps*len(samples)]))
            except:
                print f+'failed! exiting.'
                exit(-1)
        #lines2Write.append(thd+','+str(hmean(samples))+',')
        data_xthd.append(int(thd))
        data_ylat.append(hmean(samples))

    # calculate unbiased variance
    data_yvar.append(0)
    for l in range(1,len(data_xthd)-1):
        data_yvar.append(var(data_ylat[l-1:l+2]))
    data_yvar.append(0)
    # write back 
    fw = open(f+'.csv','w')
    fw.write('thd,lat,var\n')
    for l in range(0,len(data_xthd)):
        fw.write(str(','.join([str(data_xthd[l]),str(data_ylat[l]),str(data_yvar[l])]))+'\n')
    fw.close()
