import nmap

begin = 21
end = 80

target='192.168.100.18'

scanner = nmap.PortScanner()


for i in range(begin,end+1):


    res = scanner.scan(target,str(i))   
    res = res['scan'][target]['tcp'][i]['state']     

    print(f'port {i} is {res}.')

