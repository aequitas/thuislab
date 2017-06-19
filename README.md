Thuislab
========

The goal is to setup a homelab/homeserver for experimenting virtualisation and containerisation technologies. The homelab will provide IoT, CI and Media services on a geographically distributed network (me and my parents home). The intention is to create a as stateless configuration as possible which can be provisioned completely with configuration from this repository.

Hardware:

- HP Microserver Gen8
- Raspberry Pies
- Mikrotik routers

Layout:

- RPi
  - Docker(/Kubernetes?)
    - Home assistant
    - PiHole

- Gen8
  - ~~vSphere~~ CoreOS
    - Docker(/Kubernetes?)
      - Postgres/Mysql/Mariadb
      - AFPD/Timemachine
      - Concourse
      - PiHole
      - Media (plex and friends)
      - ~~Observium~~ LibreNMS
      - Smokeping
      - The Dude (?)
      - GitLab (?)

References:

http://www.davidc.net/sites/default/subnets/subnets.html

Todos:

- IPv6 (only)

Lessons learned/relearned:

- Don't put off version control, otherwise the changes are to large to manage.
- Git-crypt secret management only works well if you have strict discipline and structure. But still beats no encryption.
- Not using your actual secrets during development saves you from pushing them to public Git.
