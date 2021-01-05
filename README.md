# smb-docker

To use this docker, execute the following command: 

<code># docker run -itd -h smb01 --env-file envlist -w /root -v samba:/var/lib/samba \
   --privileged --dns 127.0.0.1 --name smb01 --rm \
   -p 389:389 -p 389:389/udp -p 53:53 -p 53:53/udp \
   -p 445:445 -p 88:88 -p 88:88/udp -p 464:464 -p 464:464/udp hwleong/smb</code>

The environment variable <code>DOMAIN</code>, <code>REALM</code> and <code>ADMINPASS</code>
must be defined to setup the SAMBA Domain Controller. 
