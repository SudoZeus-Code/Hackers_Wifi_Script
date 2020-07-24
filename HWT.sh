#! /bin/bash
# Sudo_Zeus
# 5/9/2020

RED='\033[0;41;30m'
STD='\33[0;0;39m'

main()
{
  clear
  echo ----------------------
  echo    HACKERS WIFI TOOL
  echo ----------------------
  echo
  echo 1. Set TX-Power
  echo 2. Monitor mode
  echo 3. Managed mode
  echo 4. Exit
}

read_options(){
  local choice
  read -p "Enter choice [1-4] :" choice
  case $choice in 
	  1) clear && Reg_Set ;;
	  2) clear && Monitor_Mode;;
	  3) clear && Managed_Mode;;
	  4) exit 0 ;;
	  *) echo -e "${RED}Error...${STD}" && sleep 2
  esac


}

Monitor_Mode()
{


  while true; do
     read -p "Do you want to set a device to monitor? y or n : " yn
     case $yn in
        [Yy]* ) break;;
        [Nn]* ) clear && main;;
        * ) echo "Please answer yes or no.";;
    esac
  done 


  iw dev | grep Interface

  read -p "Please select an interface: " interface
  echo You selected $interface
  while true; do
     read -p "Is this correct? y or n : " yn
     case $yn in
        [Yy]* ) break;;
        [Nn]* ) clear && Monitor_Mode;;
        * ) echo "Please answer yes or no.";;
    esac
  done
  
  echo Setting $interface to monitor mode.
  echo Please wait...
  iw phy phy0 interface add moni0 type monitor
  sleep 1

  
  iw_get=$(iw dev | grep Interface)
  echo "$iw_get"

  iw_get1=$(iw dev | grep type)
  echo "$iw_get1"

  read -p "Press any key to continue..."



}


Managed_Mode()
{


  while true; do
     read -p "Do you want to set a device to managed? y or n : " yn
     case $yn in
        [Yy]* ) break;;
        [Nn]* ) clear && main;;
        * ) echo "Please answer yes or no.";;
    esac
  done 

  iw dev | grep Interface

  read -p "Please select an interface: " interface
  echo You selected $interface
  while true; do
     read -p "Is this correct? y or n : " yn
     case $yn in
        [Yy]* ) break;;
        [Nn]* ) clear && Managed_Mode;;
        * ) echo "Please answer yes or no.";;
    esac
  done
  
  echo Setting $interface to managed mode.
  echo Please wait...
  iw dev $interface del
  sleep 1

  
  iw_get=$(iw dev | grep Interface)
  echo "$iw_get"

  iw_get1=$(iw dev | grep type)
  echo "$iw_get1"

  read -p "Press any key to continue..."



}






Reg_Set()
{

  read -p "Please select an interface: " interface
  echo You selected $interface
  while true; do
     read -p "Is this correct? y or n : " yn
     case $yn in
        [Yy]* ) break;;
        [Nn]* ) clear && BO_set;;
        * ) echo "Please answer yes or no.";;
    esac
  done
	
  echo Setting region to BZ.
  echo Please wait...
  iw reg set BZ
  sleep 1

  iw_get=$(iw reg get | grep country)
  echo "$iw_get"

  read -p "Press any key to continue..."
  Set_txpower "$interface"
  

}

Set_txpower()
{
  echo "$1"
  echo ----------------------
  echo    TX POWER TOOL         #echo Preparing to set Tx-power.
  echo ----------------------   #read -p" Please select an interface:" interface
  echo 
  echo Preparing to set Tx-power.
  echo
  read -p "Set txpower: " TX
  TXmbm = $TX + "mBm"
  echo "$TXmbm"

  echo You selected $txpower

  while true; do
       read -p "Is this correct? y or n" yn
       case $yn in
          [Yy]* ) break;;
          [Nn]* ) clear && Set_txpower;;
          * ) echo "Please answer yes or no.";;
      esac
  done
  
  echo Please wait...
  ip link set $interface down
  sleep 1
  iw dev $interface set txpower fixed $TXmBm
  sleep 1
  ip link set $interface up
  sleep 1
  iw dev
 
  read -p "Press enter to exit."
  exit 1

}

while true 
do 
	main
	read_options
done


