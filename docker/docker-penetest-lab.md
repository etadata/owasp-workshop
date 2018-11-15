

#### Penetration Testing Lab  with Juices-hop , Kali
####  Create a pentesting lab 
We learned :
 
* How to create a container
* How to interacte with a container 
* How to create Multiple containers
* ....

so it's time to create a lab and test our security skills on the penetration testing.

Here is the scheme of our lab 
![alt text](https://raw.githubusercontent.com/etadata/owasp-workshop/master/image-docker/pentest-lab.png "Logo Title Text 1")

#### Kali/Linux : the attacker machine
```bash
docker pull kalilinux/kali-linux-docker
```

#### Juice-shop : the Target machine

OWASP Juice Shop is an intentionally insecure webapp for security trainings written entirely in Javascript which encompasses the entire OWASP Top Ten and other severe security flaws. http://owasp-juice.shop.


https://github.com/bkimminich/juice-shop#docker-container--

- Run docker pull bkimminich/juice-shop
- Run docker run --rm -p 3000:3000 bkimminich/juice-shop
- Browse to http://localhost:3000 


Happy Hacking :).

would you like to know more about the penetration containers

### Docker for Penetration Testing

* `docker pull kalilinux/kali-linux-docker` - [Official Kali Linux](https://hub.docker.com/r/kalilinux/kali-linux-docker/).
* `docker pull owasp/zap2docker-stable` - [Official OWASP ZAP](https://github.com/zaproxy/zaproxy).
* `docker pull wpscanteam/wpscan` - [Official WPScan](https://hub.docker.com/r/wpscanteam/wpscan/).
* `docker pull citizenstig/dvwa` - [Damn Vulnerable Web Application (DVWA)](https://hub.docker.com/r/citizenstig/dvwa/).
* `docker pull wpscanteam/vulnerablewordpress` - [Vulnerable WordPress Installation](https://hub.docker.com/r/wpscanteam/vulnerablewordpress/).
* `docker pull hmlio/vaas-cve-2014-6271` - [Vulnerability as a service: Shellshock](https://hub.docker.com/r/hmlio/vaas-cve-2014-6271/).
* `docker pull hmlio/vaas-cve-2014-0160` - [Vulnerability as a service: Heartbleed](https://hub.docker.com/r/hmlio/vaas-cve-2014-0160/).
* `docker pull vulnerables/cve-2017-7494` - [Vulnerability as a service: SambaCry](https://hub.docker.com/r/vulnerables/cve-2017-7494/).
* `docker pull opendns/security-ninjas` - [Security Ninjas](https://hub.docker.com/r/opendns/security-ninjas/).
* `docker pull diogomonica/docker-bench-security` - [Docker Bench for Security](https://hub.docker.com/r/diogomonica/docker-bench-security/).
* `docker pull ismisepaul/securityshepherd` - [OWASP Security Shepherd](https://hub.docker.com/r/ismisepaul/securityshepherd/).
* `docker pull webgoat/webgoat-7.1` - [OWASP WebGoat Project 7.1 docker image](https://hub.docker.com/r/webgoat/webgoat-7.1/).
* `docker pull webgoat/webgoat-8.0` - [OWASP WebGoat Project 8.0 docker image](https://hub.docker.com/r/webgoat/webgoat-8.0/).
* `docker-compose build && docker-compose up` - [OWASP NodeGoat](https://github.com/owasp/nodegoat#option-3---run-nodegoat-on-docker).
* `docker pull citizenstig/nowasp` - [OWASP Mutillidae II Web Pen-Test Practice Application](https://hub.docker.com/r/citizenstig/nowasp/).
* `docker pull bkimminich/juice-shop` - [OWASP Juice Shop](https://github.com/bkimminich/juice-shop#docker-container--).
* `docker pull phocean/msf` - [docker-metasploit](https://hub.docker.com/r/phocean/msf/).