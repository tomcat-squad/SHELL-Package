#!/bin/bash
#AUTHOR : MCHEVRO
#GITHUB : https://github.com/mchevro
echo "=========Tomcat Squad==========";
echo "===============================";
echo "[1] Install RTMP               ";
echo "[2] Install Icecast2           ";
echo "[3] Install Samba              ";
echo "[4] Keluar Dari Program        ";
echo "===============================";
while :
do
read -p "Pilih Nomor : " pilihan;
echo "";
if [ $pilihan ]:
then 
case $pilihan in
1)  sudo apt update && apt upgrade -y
    sudo apt install nginx -y
    sudo add-apt-repository universe
    sudo apt install libnginx-mod-rtmp -y
    clear
    echo "============INSTALL RTMP==============";
    echo "[1] Publish di youtube dan localhost  ";
    echo "[2] Publish di localhost saja         ";
    echo "[3] Keluar Dari Program               ";
    echo "======================================";
    while :
    do
    read -p "Pilih Nomor : " pilihan;
    echo "";
    if [ $pilihan ]:
    then
    case $pilihan in 
    1)  while :
        do
        read -p "Input Streamkey Youtube Livestream : " STREAMKEY
        if [ $STREAMKEY ]:
        then
        sudo echo "
rtmp_auto_push on;
rtmp {
    server {
        listen 1935; #Port Untuk Stream RTMP
        chunk_size 4096;
        
        application live {
            live on;
            record off;
            push rtmp://127.0.0.1/streamout;
            }
        
        application streamout {
            live on;
            record off;
            push rtmp://a.rtmp.youtube.com/live2/$STREAMKEY;
            }
        }
}" >> /etc/nginx/nginx.conf 
        sudo systemctl restart nginx
        clear
        sudo echo "==========INSTALASI SELESAI=========="
        HOST=$(hostname -I)
        sudo echo "SERVER STREAM OBS : $HOST/live"
        sudo echo "====================================="
        break
        fi
        continue
        done
        ;;

    2)  sudo echo "
rtmp {
    server {
        listen 1935; #Port Untuk Stream RTMP
        chunk_size 4096;
        application live {
            live on;
            record off;
            }
        }
}" >> /etc/nginx/nginx.conf 
        sudo systemctl restart nginx
        clear
        echo "==========INSTALASI SELESAI==========";
        HOST=$(hostname -I);
        echo "SERVER STREAM OBS : $HOST/live";
        echo "=====================================";
        echo "";
        ;;

    3) exit;;
    esac
    break
    fi
    continue
    done
    ;;

2)  sudo apt update && apt upgrade -y
    clear
    sudo apt install icecast2 -y
    clear
    echo "==========INSTALASI SELESAI==========";
    HOST=$(hostname -I);
    echo "Buka Browser : $HOST:8000";
    echo "=====================================";
    echo "";
    ;;

3)  sudo apt update && upgrade -y
    sudo apt install samba -y
    sudo echo "
[Software]
path = /home/tomcat/software
browseable = yes
create mode = 0644
directory mode = 0644
writeable = no
guest ok = yes
    " >> /etc/samba/smb.conf
    mkdir /home/tomcat/software
    chmod 0755 -R /home/tomcat/software
    systemctl restart smbd
    clear
    echo "======INSTALASI SELESAI======";
    HOST=$(hostname -I);
    echo "Buka File Explorer : \\ $HOST";
    ;;

4)  exit
    ;;
esac
break
fi
continue
done
