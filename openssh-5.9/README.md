Anatomy of a Real Linux Intrusion Part II: OpenSSH trojanized toolkit

http://blog.angelalonso.es/2016/09/anatomy-of-real-linux-intrusion-part-ii.html
http://blog.angelalonso.es/2016/09/anatomy-of-real-linux-intrusion-part-ii_19.html

 - Script 1 (p): checking the necessary tools
 - Script 2 (p1): Compiling a Trojanized version of SSH and testing it
 - Script 3 (p2): Installing the Trojanized SSH tools
 - Script 4 (p3): Installing tools(side_files.tgz) to make more difficult any forensic investigation

## Backdoor capabilities
 - A rootkit and backdoor for Linux system across different platforms and architecture
 - Local rootshell
 - The main SSHD binary is overwritten with a malicious binary. This binary contains a backdoor password to ensure access. Also, any access with that password is not tracked. This password is PRtestD

## Multi architecture and modular approach:
 - It uses a modular approach with different scripts involved.
 - Depending on the OS and the architecture different files are download and executed.

## Sniffing capabilities:
 - Several other binaries like scp, sftp, ssh are trojanized to steal username / passwords

## Anti-forensic capabilities:
 - Remove some logs to delete evidences  (/var/log/messages, /var/log/secure, /var/log/lastlog, /var/log/wtmp)
 - Modify timestamp of files

## Rootkit capabilities:
 - Hidden processes and files through different techniques

## C2C capabilities:
 - Communication with C&C every hour to inform of any change in the system (eg: new IP)
 - Communication with C&C every hour to pull any update
