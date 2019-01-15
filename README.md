# Setup Kanboard on bare VM-Alpine
This has been developed (and only tested) with the VM-version of Alpine 3.8 and
Kanboard 1.2.7. First, get this repository as a tar.gz:
```
apk udpate
apk add curl
cd /tmp
curl -sL -o kb-alp.tar.gz https://github.com/asprionj/kb-alp/tarball/master
tar -xvzf kb-alp.tar.gz
```
Then, just run the setup script:
```
sh asprionj-kb-alp-*/setup.sh
```
