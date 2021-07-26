## ICECAST2 + HTTPS (WAJIB ADA IP PUBLIC DAN DOMAIN)

##### 1. Instalasi Package
    ```
      sudo sh -c "echo deb http://download.opensuse.org/repositories/multimedia:/xiph/xUbuntu_18.10/ ./ >>/etc/apt/sources.list.d/icecast.list"
      wget -qO - https://build.opensuse.org/projects/multimedia:libs/public_key | sudo apt-key add -
      sudo apt update -y
      apt-get install icecast2
      apt-get install certbot
    ```
##### 2. Edit Konfigurasi Berikut Untuk Membuat Binding Port Icecast Ke 80, Dengan Cara Uncoment Pada Bagian <changeowner>
    ```
      nano /etc/icecast2/icecast.xml
    ```
  
    ````
     <security>
        <chroot>0</chroot>
        <changeowner>
          <user>icecast2</user>
          <group>icecast</group>
         <changeowner>
     </security>
    ```
      
##### 3. Memberitahu System Untuk Menjalankan Icecast Sebagai Root Dengan Cara Di Edit
    ```
      nano /etc/default/icecast2
    ```
    ```
      USERID=root
      GROUPID=root
    ```
##### 4. Membuat SSL 
    ```
      certbot certonly --webroot-path="/usr/share/icecast2/web" -d 'live.tomcatsquad.web.id'
      cat /etc/letsencrypt/live/live.tomcatsquad.web.id/fullchain.pem /etc/letsencrypt/live/live.tomcatsquad.web.id/privkey.pem > /etc/icecast2/bundle.pem
      chmod 666 /etc/icecast2/bundle.pem
    ```
##### 5. Konfigurasi Icecast Untuk SSL
      ```
          nano /etc/icecast2/icecast.xml
      ```
       
      Tambahka listen port ssl
      ```
          <listen-socket>
            <port>443</port>
              <ssl>1</ssl>
          </listen-socket>
      ```
##### 6. Restart Icecast
      ```
          sudo service icecast2 restart
      ```
            
##### 7. Settingan Untuk Mixx
![WhatsApp Image 2021-07-27 at 01 43 03](https://user-images.githubusercontent.com/67460437/127045429-a045e75a-8edc-4b2f-8fc4-58119383c12a.jpeg)
