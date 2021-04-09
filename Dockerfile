FROM centos
WORKDIR /root
RUN yum -y install epel-release glibc-langpack-en
RUN yum -y install --enablerepo powertools wget python3 python3-devel perl gcc-c++ lmdb-devel gnutls-devel gpgme-devel jansson-devel libarchive-devel libacl-devel openldap-devel pam-devel krb5-server texinfo zlib-devel perl-Parse-Yapp dbus-devel krb5-devel rpcgen python2-dns python2-dns
RUN wget https://download.samba.org/pub/samba/samba-4.13.7.tar.gz
RUN tar xvf samba-4.13.7.tar.gz
WORKDIR /root/samba-4.13.7
RUN ["./configure", "--prefix=/usr/local", "--localstatedir=/var", "--sysconfdir=/etc", "--with-system-mitkrb5", "--with-experimental-mit-ad-dc", "--without-systemd", "--enable-fhs"]
RUN make
RUN make install
WORKDIR /root
COPY smb.sh .
CMD ["sh", "smb.sh"]
