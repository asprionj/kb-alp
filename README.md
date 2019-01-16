# Setup Kanboard on bare VM-Alpine
This repository is for setting up [Kanboard](https://kanboard.org/), an IMHO
pretty awesome "free and open source Kanban project management software".
I wanted to run it with Docker (which in a test environment worked flawlessly),
but cannot get Docker in the production environment, only VM's on Windows'
Hyper-V.

This has been developed (and only tested) with the VM-version of Alpine 3.8 and
Kanboard 1.2.7, on a 2nd-generation VM on Hyper-V under Windows 10. This
repository is to large parts the `docker/` folder from release 1.2.7 of
[Kanboard's GitHub repository](https://github.com/kanboard/kanboard). The
setup script is adapted from the `Dockerfile` in the same repository.

Note that in this version, a hard-coded APK-repositories file is used;
`etc/apk/repositories`. Make sure to change the server to your preferred one
before running `setup.sh`. A better approach would be to take the repository
selected during `setup-alpine`, which is (usually?) the second line in the
generated `repositories` file. Didn't want to hassle with `head` and diverting
stuff to (temporary) files...

## User Guide
First, set up an Alpine system. I used a VM with only 2GB disk and it worked
fine. After the installation of Kanboard (without any plugins etc.), the entire
setup uses 163MB of disk space on `/`.

Log in to Alpine (as `root`), get this repository as a tar.gz, and unpack it:
```
apk udpate
apk add curl
cd /tmp
curl -sL -o kb-alp.tar.gz https://github.com/asprionj/kb-alp/tarball/master
tar -xvzf kb-alp.tar.gz
rm kb-alp.tar.gz
```
Then, just run the setup script:
```
sh asprionj-kb-alp-*/setup.sh
```

If anyone else tries this, please let me know if it works for you as well!
