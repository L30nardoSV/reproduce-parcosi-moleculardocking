import sys
import os
import csv
import pandas as pd

def retrieve_runtime(filename):
    """Retrieve runtime (s) from dlg"""

    with open(filename, "rt") as myfile:   # open file for reading text
        lines = myfile.readlines()

        found_keyword = False

        for line in lines:
            if line.startswith('Run time'):
                found_keyword = True
           
            if found_keyword:
                runtime = float(line[9:15])
                found_keyword = False
                #print(runtime)
        
    return runtime

def parse_dirname(dirname):
    name_list = dirname.split('_')
    test = name_list[1]
    version = name_list[2]
    device = name_list[3]
    return test, version, device

def parse_filename(filename):
    head, tail = os.path.split(filename)
    #print("Filename head: %s" %(head))
    #print("Filename tail: %s" %(tail))
    name_list = tail.replace('.', '_')
    name_list = name_list.split('_')
    #print(name_list)

    nwi = name_list[2]
    version = name_list[3]
    pdb = name_list[4]
    ls = name_list[5]

    return ls, version, nwi, pdb

def reorder_metafile(metafile):

    # --------------------------------------------------------------------
    # Sublists
    list_1u4d, list_1xoz, list_1yv3, list_1owe, list_1oyt, list_1ywr, list_1t46, list_2bm2, list_1mzc, list_1r55 = [['0', '0', '0', '0'] for i in range(10)]
    list_5wlo, list_1kzk, list_3s8o, list_5kao, list_1hfs, list_1jyq, list_2d1o, list_3drf, list_4er4, list_3er5 = [['0', '0', '0', '0'] for i in range(10)]

    for idx in metafile:
        if idx[3] == '1u4d':
            if idx[2] == '32wi': list_1u4d[0] = idx
            elif idx[2] == '64wi': list_1u4d[1] = idx
            elif idx[2] == '128wi': list_1u4d[2] = idx
            elif idx[2] == '256wi': list_1u4d[3] = idx
            else: print('error')
        elif idx[3] == '1xoz':
            if idx[2] == '32wi': list_1xoz[0] = idx
            elif idx[2] == '64wi': list_1xoz[1] = idx
            elif idx[2] == '128wi': list_1xoz[2] = idx
            elif idx[2] == '256wi': list_1xoz[3] = idx
            else: print('error')
        elif idx[3] == '1yv3':
            if idx[2] == '32wi': list_1yv3[0] = idx
            elif idx[2] == '64wi': list_1yv3[1] = idx
            elif idx[2] == '128wi': list_1yv3[2] = idx
            elif idx[2] == '256wi': list_1yv3[3] = idx
            else: print('error')
        elif idx[3] == '1owe':
            if idx[2] == '32wi': list_1owe[0] = idx
            elif idx[2] == '64wi': list_1owe[1] = idx
            elif idx[2] == '128wi': list_1owe[2] = idx
            elif idx[2] == '256wi': list_1owe[3] = idx
            else: print('error')
        elif idx[3] == '1oyt':
            if idx[2] == '32wi': list_1oyt[0] = idx
            elif idx[2] == '64wi': list_1oyt[1] = idx
            elif idx[2] == '128wi': list_1oyt[2] = idx
            elif idx[2] == '256wi': list_1oyt[3] = idx
            else: print('error')       
        elif idx[3] == '1ywr':
            if idx[2] == '32wi': list_1ywr[0] = idx
            elif idx[2] == '64wi': list_1ywr[1] = idx
            elif idx[2] == '128wi': list_1ywr[2] = idx
            elif idx[2] == '256wi': list_1ywr[3] = idx
            else: print('error')
        elif idx[3] == '1t46':
            if idx[2] == '32wi': list_1t46[0] = idx
            elif idx[2] == '64wi': list_1t46[1] = idx
            elif idx[2] == '128wi': list_1t46[2] = idx
            elif idx[2] == '256wi': list_1t46[3] = idx
            else: print('error')
        elif idx[3] == '2bm2':
            if idx[2] == '32wi': list_2bm2[0] = idx
            elif idx[2] == '64wi': list_2bm2[1] = idx
            elif idx[2] == '128wi': list_2bm2[2] = idx
            elif idx[2] == '256wi': list_2bm2[3] = idx
            else: print('error')
        elif idx[3] == '1mzc':
            if idx[2] == '32wi': list_1mzc[0] = idx
            elif idx[2] == '64wi': list_1mzc[1] = idx
            elif idx[2] == '128wi': list_1mzc[2] = idx
            elif idx[2] == '256wi': list_1mzc[3] = idx
        elif idx[3] == '1r55':
            if idx[2] == '32wi': list_1r55[0] = idx
            elif idx[2] == '64wi': list_1r55[1] = idx
            elif idx[2] == '128wi': list_1r55[2] = idx
            elif idx[2] == '256wi': list_1r55[3] = idx
            else: print('error')
        elif idx[3] == '5wlo':
            if idx[2] == '32wi': list_5wlo[0] = idx
            elif idx[2] == '64wi': list_5wlo[1] = idx
            elif idx[2] == '128wi': list_5wlo[2] = idx
            elif idx[2] == '256wi': list_5wlo[3] = idx
            else: print('error')
        elif idx[3] == '1kzk':
            if idx[2] == '32wi': list_1kzk[0] = idx
            elif idx[2] == '64wi': list_1kzk[1] = idx
            elif idx[2] == '128wi': list_1kzk[2] = idx
            elif idx[2] == '256wi': list_1kzk[3] = idx
            else: print('error')
        elif idx[3] == '3s8o':
            if idx[2] == '32wi': list_3s8o[0] = idx
            elif idx[2] == '64wi': list_3s8o[1] = idx
            elif idx[2] == '128wi': list_3s8o[2] = idx
            elif idx[2] == '256wi': list_3s8o[3] = idx
            else: print('error')
        elif idx[3] == '5kao':
            if idx[2] == '32wi': list_5kao[0] = idx
            elif idx[2] == '64wi': list_5kao[1] = idx
            elif idx[2] == '128wi': list_5kao[2] = idx
            elif idx[2] == '256wi': list_5kao[3] = idx
            else: print('error')
        elif idx[3] == '1hfs':
            if idx[2] == '32wi': list_1hfs[0] = idx
            elif idx[2] == '64wi': list_1hfs[1] = idx
            elif idx[2] == '128wi': list_1hfs[2] = idx
            elif idx[2] == '256wi': list_1hfs[3] = idx
            else: print('error')
        elif idx[3] == '1jyq':
            if idx[2] == '32wi': list_1jyq[0] = idx
            elif idx[2] == '64wi': list_1jyq[1] = idx
            elif idx[2] == '128wi': list_1jyq[2] = idx
            elif idx[2] == '256wi': list_1jyq[3] = idx
            else: print('error')
        elif idx[3] == '2d1o':
            if idx[2] == '32wi': list_2d1o[0] = idx
            elif idx[2] == '64wi': list_2d1o[1] = idx
            elif idx[2] == '128wi': list_2d1o[2] = idx
            elif idx[2] == '256wi': list_2d1o[3] = idx
            else: print('error')
        elif idx[3] == '3drf':
            if idx[2] == '32wi': list_3drf[0] = idx
            elif idx[2] == '64wi': list_3drf[1] = idx
            elif idx[2] == '128wi': list_3drf[2] = idx
            elif idx[2] == '256wi': list_3drf[3] = idx
            else: print('error')
        elif idx[3] == '4er4':
            if idx[2] == '32wi': list_4er4[0] = idx
            elif idx[2] == '64wi': list_4er4[1] = idx
            elif idx[2] == '128wi': list_4er4[2] = idx
            elif idx[2] == '256wi': list_4er4[3] = idx
            else: print('error')
        elif idx[3] == '3er5':
            if idx[2] == '32wi': list_3er5[0] = idx
            elif idx[2] == '64wi': list_3er5[1] = idx
            elif idx[2] == '128wi': list_3er5[2] = idx
            elif idx[2] == '256wi': list_3er5[3] = idx
            else: print('error') 
        else:
            print('error!, \t%s, \t%s' %(idx[3], idx[2]))

 #   print(list_1u4d); print(list_1xoz); print(list_1yv3); print(list_1owe); print(list_1oyt)
 #   print(list_1ywr); print(list_1t46); print(list_2bm2); print(list_1mzc); print(list_1r55)
 #   print(list_5wlo); print(list_1kzk); print(list_3s8o); print(list_5kao); print(list_1hfs)
 #   print(list_1jyq); print(list_2d1o); print(list_3drf); print(list_4er4); print(list_3er5)

    reordered_metafile = []

    reordered_metafile = list_1u4d + list_1xoz + list_1yv3 + list_1owe + list_1oyt + \
                         list_1ywr + list_1t46 + list_2bm2 + list_1mzc + list_1r55 + \
                         list_5wlo + list_1kzk + list_3s8o + list_5kao + list_1hfs + \
                         list_1jyq + list_2d1o + list_3drf + list_4er4 + list_3er5

    # --------------------------------------------------------------------
    # Sublists: pdb vs runtimes
    R_1u4d, R_1xoz, R_1yv3, R_1owe, R_1oyt, R_1ywr, R_1t46, R_2bm2, R_1mzc, R_1r55 = [['0', '0', '0', '0', '0'] for i in range(10)]
    R_5wlo, R_1kzk, R_3s8o, R_5kao, R_1hfs, R_1jyq, R_2d1o, R_3drf, R_4er4, R_3er5 = [['0', '0', '0', '0', '0'] for i in range(10)]

    R_1u4d[0] = '1u4d'; R_1xoz[0] = '1xoz'; R_1yv3[0] = '1yv3'; R_1owe[0] = '1owe'; R_1oyt[0] = '1oyt'
    R_1ywr[0] = '1ywr'; R_1t46[0] = '1t46'; R_2bm2[0] = '2bm2'; R_1mzc[0] = '1mzc'; R_1r55[0] = '1r55'
    R_5wlo[0] = '5wlo'; R_1kzk[0] = '1kzk'; R_3s8o[0] = '3s8o'; R_5kao[0] = '5kao'; R_1hfs[0] = '1hfs'
    R_1jyq[0] = '1jyq'; R_2d1o[0] = '2d1o'; R_3drf[0] = '3drf'; R_4er4[0] = '4er4'; R_3er5[0] = '3er5'

    # CAUTION
    # Might need to replaced range(4) for range(1),
    # as some folders contain results only for one case (numwi=32)
    # instead of four ones (numwi={32, 64, 128, 256})
    for i in range(4):
        R_1u4d[i+1] = list_1u4d[i][4]; R_1xoz[i+1] = list_1xoz[i][4]; R_1yv3[i+1] = list_1yv3[i][4]; R_1owe[i+1] = list_1owe[i][4]
        R_1oyt[i+1] = list_1oyt[i][4]; R_1ywr[i+1] = list_1ywr[i][4]; R_1t46[i+1] = list_1t46[i][4]; R_2bm2[i+1] = list_2bm2[i][4]
        R_1mzc[i+1] = list_1mzc[i][4]; R_1r55[i+1] = list_1r55[i][4]; R_5wlo[i+1] = list_5wlo[i][4]; R_1kzk[i+1] = list_1kzk[i][4]
        R_3s8o[i+1] = list_3s8o[i][4]; R_5kao[i+1] = list_5kao[i][4]; R_1hfs[i+1] = list_1hfs[i][4]; R_1jyq[i+1] = list_1jyq[i][4]
        R_2d1o[i+1] = list_2d1o[i][4]; R_3drf[i+1] = list_3drf[i][4]; R_4er4[i+1] = list_4er4[i][4]; R_3er5[i+1] = list_3er5[i][4]

 #   print(R_1u4d); print(R_1xoz); print(R_1yv3); print(R_1owe); print(R_1oyt)
 #   print(R_1ywr); print(R_1t46); print(R_2bm2); print(R_1mzc); print(R_1r55)
 #   print(R_5wlo); print(R_1kzk); print(R_3s8o); print(R_5kao); print(R_1hfs)
 #   print(R_1jyq); print(R_2d1o); print(R_3drf); print(R_4er4); print(R_3er5)

    reordered_runtimes_metafile = []
    reordered_runtimes_metafile = [R_1u4d] + [R_1xoz] + [R_1yv3] + [R_1owe] + [R_1oyt] + \
                                  [R_1ywr] + [R_1t46] + [R_2bm2] + [R_1mzc] + [R_1r55] + \
                                  [R_5wlo] + [R_1kzk] + [R_3s8o] + [R_5kao] + [R_1hfs] + \
                                  [R_1jyq] + [R_2d1o] + [R_3drf] + [R_4er4] + [R_3er5]

    return reordered_metafile, reordered_runtimes_metafile

def main():
    dirname = sys.argv[1]   # first argument is the folder containing .dlg files

    test, folder_version, device = parse_dirname(dirname)
    #print(test, version, device)

    list_files = os.listdir(dirname)
    #print(list_files)

    csv_sw_metafile = []
    csv_ad_metafile = []

    for filename in list_files:
        ls, version, nwi, pdb = parse_filename(dirname + '/' + filename)
        runtime = retrieve_runtime(dirname + '/' + filename)
        #print('%s, \t%s, \t%s, \t%s, \t%6.2f' %(ls, version, nwi, pdb, runtime))
        csv_row = []
        csv_row.extend([ls, version, nwi, pdb, runtime])
        if ls == "sw":
            csv_sw_metafile.extend([csv_row])
        elif ls == "ad":
            csv_ad_metafile.extend([csv_row])

    #print(csv_sw_metafile)

    csv_ordered_sw_metafile = []; csv_ordered_ad_metafile = []
    csv_ordered_sw_runtimes_metafile = []; csv_ordered_ad_runtimes_metafile = []

    # CAUTION
    # Might need to comment one of the following two function calls
    # as there are cases where either SW or AD results are not present
    csv_ordered_sw_metafile, csv_ordered_sw_runtimes_metafile = reorder_metafile(csv_sw_metafile)
    csv_ordered_ad_metafile, csv_ordered_ad_runtimes_metafile = reorder_metafile(csv_ad_metafile)

    #print(csv_ordered_sw_metafile)
    #print(csv_ordered_ad_metafile)

    #print(csv_ordered_sw_runtimes_metafile)
    #print(csv_ordered_ad_runtimes_metafile)

    # Produce csv files with all details
#    with open('myresults_sw.csv', 'w', newline='') as file:
#        writer = csv.writer(file)
#        writer.writerow(["LS method", "Version", "NUMWI", "PDB", "Run time(s)"])
#        for row in csv_ordered_sw_metafile:
#            writer.writerow(row)
    
#    with open('myresults_ad.csv', 'w', newline='') as file:
#        writer = csv.writer(file)
#        writer.writerow(["LS method", "Version", "NUMWI", "PDB", "Run time(s)"])
#        for row in csv_ordered_ad_metafile:
#            writer.writerow(row)

    # Produce csv files only with runtimes only

    filename_sw = 'myresults_sw' + '_' + test + '_' + folder_version + '_' + device
    filename_ad = 'myresults_ad' + '_' + test + '_' + folder_version + '_' + device

    filename_sw_csv = filename_sw + '.csv'
    filename_ad_csv = filename_ad + '.csv'

    filename_sw_txt = filename_sw + '.txt'
    filename_ad_txt = filename_ad + '.txt'

    filename_sw_xlsx = filename_sw + '.xlsx'
    filename_ad_xlsx = filename_ad + '.xlsx'

    with open(filename_sw_csv, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(["pdb", "32wi", "64wi", "128wi", "256wi"])
        for row in csv_ordered_sw_runtimes_metafile:
            writer.writerow(row)

    with open(filename_ad_csv, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(["pdb", "32wi", "64wi", "128wi", "256wi"])
        for row in csv_ordered_ad_runtimes_metafile:
            writer.writerow(row)
    
    # Changing file extension: from csv into txt
    os.rename(filename_sw_csv, filename_sw_txt)
    os.rename(filename_ad_csv, filename_ad_txt)

    # Transforming files: from txt into excel
    pd.read_csv(filename_sw_txt, delimiter=",").to_excel(filename_sw_xlsx, index=False)
    pd.read_csv(filename_ad_txt, delimiter=",").to_excel(filename_ad_xlsx, index=False)

main()

# python3 parse_adgpu_dlg.py results_numwi_opencl_rtx2070super


