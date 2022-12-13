FROM rockylinux
WORKDIR /root
RUN yum -y install epel-release glibc-langpack-en
RUN yum -y install --enablerepo=powertools wget python3 python3-devel perl gcc-c++ lmdb-devel gnutls-devel gpgme-devel jansson-devel libarchive-devel libacl-devel openldap-devel pam-devel krb5-server texinfo zlib-devel perl-Parse-Yapp dbus-devel krb5-devel rpcgen python2-dns python3-dns bind-utils telnet python3-markdown chrony
RUN wget https://download.samba.org/pub/samba/samba-4.14.14.tar.gz
RUN tar xvf samba-4.14.14.tar.gz
WORKDIR /root/samba-4.14.14
RUN ["./configure", "--prefix=/usr/local", "--localstatedir=/var", "--sysconfdir=/etc", "--with-system-mitkrb5", "--with-experimental-mit-ad-dc", "--without-systemd", "--enable-fhs"]
RUN make
RUN make install
WORKDIR /root
COPY smb.sh .
COPY chrony.conf /etc
CMD ["sh", "smb.sh"]
