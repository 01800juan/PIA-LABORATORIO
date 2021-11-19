# Escaneo de Subred
#
# Matricula:1910139
# Elaborado por: Juan Angel Facundo Lopez 
# Fecha:11/10/21
#

# impresion de opciones del menu
Function showmenu {
    Clear-Host
    Write-Host "Selecciona..."
    Write-Host "1. Subred"
    Write-Host "2. Ip"
    Write-Host "3. Activos"
    Write-Host "4. Salir"
}

showmenu

while(($inp = Read-Host -Prompt "Selecciona una opcion") -ne "4"){

switch($inp){
       
# opcion 1 del menu        
1 {
            Clear-Host
            Write-Host "------------------------------";

$subred = (Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
Write-Host "Tu gateway: $subred"
#
## Determinando rango de subred
#
$rango = $subred.Substring(0,$subred.IndexOf('.') + 1 + $subred.Substring($subred.IndexOf('.') + 1).IndexOf('.') + 3)
echo $rango
#
## Determinando si $rango termina en "."
## En ocasiones el rango de subred no termina en punto, necesitamos forzarlo.
#
$punto = $rango.EndsWith('.')
if ( $punto -like "False" )
{
    $rango = $rango +  '.' #agregamos el punto en caso de que no estuviera.
}
#
## Creamos un array con 254 numeros ( 1 a 254) y se almacenan
## En una variable que se llamara $rango_ip
#
$rango_ip = @(1..254)
#
## Generamos bucle foreach para validar hosts activos en nuestra subred.
#
foreach ( $r in $rango_ip )
{
    $actual = $rango + $r # se genera dirección ip
    $responde = Test-Connection $actual -Quiet -Count 1 #Validamos conexión contra ip actual.
    if ( $responde -eq "True" )
    {
        Write-Output ""
        Write-Host "Host responde: " -NoNewline; Write-Host $actual -ForegroundColor Green
    }
};
            Write-Host "------------------------------";
            pause;
            break
        }


# opcion 2 del menu     

2 {
            Clear-Host
            Write-Host "------------------------------";

$subred = (Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
Write-Host "== Determinando tu gateway ..."
Write-Host "Tu gateway: $subred"
#
## Determinando rango de subred
#
$rango = $subred.Substring(0,$subred.IndexOf('.') + 1 + $subred.Substring($subred.IndexOf('.') + 1).IndexOf('.') + 3 )
Write-Host "== Determinando tu rango de subred ..."
echo $rango
#
## Determinando si $rango termina en "."
## En ocasiones el rango de subred no termina en punto, necesitamos forzarlo.
#
$punto = $rango.EndsWith('.')
if ( $punto -like "false" )
{
	$rango = $rango + '.'
}
#
## Definimos un array con puertos a escanear
## Establecemos una variable para waittime
#
$portstoscan = @(20,21,22,23,25,50,51,53,80,110,119,135,136,137,138,139,143,161,162,389,443,445,636,1025,1443,3389,5985,5985,5986,8080,10000)
$waittime = 100
#
## Solicitamos dirección ip a escanear
#
Write-Host "Direccion ip a escanear: " -NoNewline
$direccion = Read-Host
#
## Generamos bucle foreach para evaluar cada puerto en $portscan
#
foreach ( $p in $portstoscan )
{
	$TCPObject = new-object System.Net.Sockets.TcpCLient
	   try{ $resultado = $TCPObject.ConnectAsync($direccion,$p).Wait($waittime)}catch{}
	   if ( $resultado -eq "True")
	   {
	       Write-Host "Puerto abierto: " -NoNewline; Write-Host $p -ForegroundColor Green
}
	   
};
            Write-Host "------------------------------";
            pause; 
            break
        }



# opcion 3 del menu     

3 {
            Clear-Host
            Write-Host "------------------------------";

$subred = (Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
Write-Host "== Determinando tu gateway ..."
Write-Host "Tu gateway: $subred"
#
## Determinando rango de subred
#
$rango = $subred.Substring(0,$subred.IndexOf('.') + 1 + $subred.Substring($subred.IndexOf('.') + 1).IndexOf('.') + 3 )
Write-Host "== Determinando tu rango de subred ..."
echo $rango
#
## Determinando si $rango termina en "."
## En ocasiones el rango de subred no termina en punto, necesitamos forzarlo.
#
$punto = $rango.EndsWith('.')
if ( $punto -like "false" )
{
	$rango = $rango + '.'
}
#
## Creamos un array con 254 numeros ( 1 a 254) y se almacenan
## En una variable que se llamara $rango_ip
#
$rango_ip = @(1..254)
#
## Generamos bucle foreach para validar hosts activos en nuestra subred.
#

Write-Output ""
Write-Host "-- Subred actual:"
Write-Host "Escaneando: " -NoNewline ;Write-Host $rango -NoNewline; Write-Host "0/24" -ForegroundColor Red
Write-Output ""
foreach ( $r in $rango_ip )
{
	$actual = $rango + $r # se genera dirección ip
	$responde = Test-Connection $actual -Quiet -Count 1 #Validamos conexión contra ip actual.
	if ( $responde -eq "True")
	{
	Write-Output ""
	Write-Host " Host responde: " -NoNewline; Write-host $actual -ForegroundColor Green
	}
};
            Write-Host "------------------------------"; 
            pause;
            break
            }



        4 {"Salir"; break}
        default {Write-Host -ForegroundColor red -BackgroundColor white "Invalid option. Please select another option";pause}
        
    }

showmenu
}
