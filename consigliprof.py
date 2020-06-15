import random
import time
import copy
#liste degli array
list = [random.sample(range(1, 1001), 1000),random.sample(range(1, 10001), 10000),random.sample(range(1, 100001), 100000),random.sample(range(1, 1000001), 1000000), random.sample(range(1, 10000001), 10000000),random.sample(range(1, 100000001), 100000000)]
#


##########vari algoritmi di ordinamento############
def bubbleSort(x):
    for passnum in range(len(x)-1,0,-1):
        for i in range(passnum):
            if x[i]>x[i+1]:
                temp = x[i]
                x[i] = x[i+1]
                x[i+1] = temp

#selction sort
def selection_sort(L):
    for i in range(len(L)-1):
        min_index = i
        for j in range(i+1, len(L)-1):
            if L[j] < L[min_index]:
                min_index = j
        L[i], L[min_index] = L[min_index], L[i]

#heap sort
from heapq import heappop, heappush
# heapify --> 
def heapify(arr, n, i):
   largest = i # largest value
   l = 2 * i + 1 # left
   r = 2 * i + 2 # right
   # if left child exists
   if l < n and arr[i] < arr[l]:
      largest = l
   # if right child exits
   if r < n and arr[largest] < arr[r]:
      largest = r
   # root
   if largest != i:
      arr[i],arr[largest] = arr[largest],arr[i] # swap
      # root.
      heapify(arr, n, largest)
def heap_sort(arr):
    n = len(arr)
   # maxheap
    for i in range(n, -1, -1):
      heapify(arr, n, i)
   # element extraction
    for i in range(n-1, 0, -1):
      arr[i], arr[0] = arr[0], arr[i] # swap
      heapify(arr, i, 0)      
#################################MERGESORT
def mergeSort(alist):       
   if len(alist)>1:
       mid = len(alist)//2
       lefthalf = alist[:mid]
       righthalf = alist[mid:]
       #ricorsione
       mergeSort(lefthalf)
       mergeSort(righthalf)
       i=0
       j=0
       k=0
       while i < len(lefthalf) and j < len(righthalf):
           if lefthalf[i] < righthalf[j]:
               alist[k]=lefthalf[i]
               i=i+1
           else:
               alist[k]=righthalf[j]
               j=j+1
           k=k+1

       while i < len(lefthalf):
           alist[k]=lefthalf[i]
           i=i+1
           k=k+1

       while j < len(righthalf):
           alist[k]=righthalf[j]
           j=j+1
           k=k+1
##### QUICK -SORT 
def quicksort_recursive(a):
    if len(a) == 0: #direi <1 perche se la lista ha un elemento solo comunque è gia ordinata
        return a
    p = len(a) // 2
    l = [i for i in a if i < a[p]] #vado a vedere se tutti gli elementi i sono minori
    m = [i for i in a if i == a[p]]
    r = [i for i in a if i > a[p]]
    return quicksort_recursive(l) + m + quicksort_recursive(r)
#tabellina dove inserisco i valori
table = [["","Bubble","SelSort","HeapSort","Merge","Quick","Nativo"],
    ["1k","","","","","",""],
    ["10k","","","","","",""],
    ["100k","","","","","",""],
    ["1kk", "-","-","","","",""],
    ["10kk","-","-","","","",""],
    ["100kk","-","-","-","-","-",""]
]
#per ogni colonna inserisco il valore in secondi del tempo di esec
x=0
for j in table:

    
    #if x <6 perche il nativo viene calcolato su piu array della lista
    if x < 6:
        
        
        start_timeNativo = time.time()
        #utlizzo il copy per copiare il valore della lista ad ogni ciclo
        z =copy.copy(list[x])
        sorted(z) #applico algoritmo di ordinamento nativo sulla lista x copiata
        time.time() - start_timeNativo #per trovare il tempo faccio time -starttime secondi passati
        table[x+1][6]=round(time.time() - start_timeNativo,3)#sostituisco il valore della tabella

        if x <5:
                    start_timeHp = time.time()
                    c = copy.copy(list[x])
                    heap_sort(c)
                    
                    time.time() - start_timeHp
                    table[x+1][3]=round(time.time() - start_timeHp,3)
                    start_timeMerge = time.time()
                    d = copy.copy(list[x])
                    mergeSort(d)
                    
                    time.time() - start_timeMerge
                    table[x+1][4]=round(time.time() - start_timeMerge,3)
                    start_timeQuick = time.time()
                    e = copy.copy(list[x])
                    quicksort_recursive(e)
                    
                    time.time()-start_timeQuick
                    table[x+1][5]=round(time.time()-start_timeQuick,3)
                    

        if x <3 :
                    start_timeBubble = time.time()
                    a = copy.copy(list[x])                
                    bubbleSort(a)
                    
                    
                    time.time() - start_timeBubble
                    table[x+1][1]=round(time.time() - start_timeBubble,3)
                    start_timeselsort = time.time()
                    b = copy.copy(list[x])
                    selection_sort(b)
                   
                    time.time() - start_timeselsort
                    table[x+1][2]=round(time.time() - start_timeselsort,3)
                    
        print(table[x+1])
        x= x+1 #incremento x cosi ad ogni ciclo sostiuiso il valore giusto della tabella e della lista array
#stampo la tabella 
def print_table(table):
    longest_cols = [
        (max([len(str(row[i])) for row in table])+4 ) #4spazi possiamo fare il join con | al posto ""
        for i in range(len(table[0]))
    ]
    row_format = "".join(["{:>" + str(longest_col) + "}" for longest_col in longest_cols])
    for row in table:
        print(row_format.format(*row))

#print_table(table)




