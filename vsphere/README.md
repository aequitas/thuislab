vSphere (hydra)

Top level virtualization, allows optionally multiple kubernaties installation or different container osses.

Checklist:

- download/install esxi
- activate free license
- install certificate

Instructions

    dd if=assets/VMware-VMvisor-Installer-201701001-4887370.x86_64.iso of=/dev/rdisk3 bs=1m

    nmap -p 17988 -oG - 192.168.88.0/24 |grep open | awk '{print $2}'

https://noteits.net/2015/06/24/installing-esxi-6-0-with-4gb-ram-or-less/rtrtr
Certificate: https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=2113926
Hostname: https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1010821
https://kubernetes.io/docs/getting-started-guides/vsphere/


    brew install packer terraform
    [root@hydra:~] esxcli system settings advanced set -o /Net/GuestIPHack -i 1

