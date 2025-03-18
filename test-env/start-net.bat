REM Notes:
REM   1. Make sure that the containers started by this script are not already running.
REM   2. If you want to check IP assignments, then you need to make sure that the tool 
REM      "jq.exe" is installed in the same directory as this script.

SET PWD=%~dp0
SET PWD=%PWD:~0,-1%
SET CONTAINER="ssh-tunneling"

SET SSH_KEY=private.key

REM host1    192.168.1.10
REM host2    192.168.1.11
REM gateway1 192.168.1.12
REM host3    192.168.1.13
REM gateway2 192.168.1.14
REM host4    192.168.1.15

SET IP0=192.168.1.10
SET IP1=192.168.1.11
SET IP2=192.168.1.12
SET IP3=192.168.1.13
SET IP4=192.168.1.14
SET IP5=192.168.1.15

SET NAME0=host1
SET NAME1=host2
SET NAME2=gateway1
SET NAME3=host3
SET NAME4=gateway2
SET NAME5=host4

SET PORT0=2200
SET PORT1=2201
SET PORT2=2202
SET PORT3=2203
SET PORT4=2204
SET PORT5=2205


docker network create --subnet=192.168.1.0/24 test_network

docker run --detach ^
           --net=test_network ^
           --ip %IP0% ^
           --interactive ^
           --tty ^
           --rm ^
           --publish %PORT0%:22/tcp ^
           --name %NAME0% ^
           %CONTAINER%

docker run --detach ^
           --net=test_network ^
           --ip %IP1% ^
           --interactive ^
           --tty ^
           --rm ^
           --publish %PORT1%:22/tcp ^
           --name %NAME1% ^
           %CONTAINER%

docker run --detach ^
           --net=test_network ^
           --ip %IP2% ^
           --interactive ^
           --tty ^
           --rm ^
           --publish %PORT2%:22/tcp ^
           --name %NAME2% ^
           %CONTAINER%

docker run --detach ^
           --net=test_network ^
           --ip %IP3% ^
           --interactive ^
           --tty ^
           --rm ^
           --publish %PORT3%:22/tcp ^
           --name %NAME3% ^
           %CONTAINER%

docker run --detach ^
           --net=test_network ^
           --ip %IP4% ^
           --interactive ^
           --tty ^
           --rm ^
           --publish %PORT4%:22/tcp ^
           --name %NAME4% ^
           %CONTAINER%

docker run --detach ^
           --net=test_network ^
           --ip %IP5% ^
           --interactive ^
           --tty ^
           --rm ^
           --publish %PORT5%:22/tcp ^
           --name %NAME5% ^
           %CONTAINER%


REM Print the list of containers.
docker container ls --all

REM Configure the containers.
ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT0% root@localhost "printf \"\n%IP0%  %NAME0%\n%IP1%  %NAME1%\n%IP2%  %NAME2%\n%IP3%  %NAME3%\n%IP4%  %NAME4%\n%IP5%  %NAME5%\n\" >> /etc/hosts"
ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT1% root@localhost "printf \"\n%IP0%  %NAME0%\n%IP1%  %NAME1%\n%IP2%  %NAME2%\n%IP3%  %NAME3%\n%IP4%  %NAME4%\n%IP5%  %NAME5%\n\" >> /etc/hosts"
ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT2% root@localhost "printf \"\n%IP0%  %NAME0%\n%IP1%  %NAME1%\n%IP2%  %NAME2%\n%IP3%  %NAME3%\n%IP4%  %NAME4%\n%IP5%  %NAME5%\n\" >> /etc/hosts"
ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT3% root@localhost "printf \"\n%IP0%  %NAME0%\n%IP1%  %NAME1%\n%IP2%  %NAME2%\n%IP3%  %NAME3%\n%IP4%  %NAME4%\n%IP5%  %NAME5%\n\" >> /etc/hosts"
ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT4% root@localhost "printf \"\n%IP0%  %NAME0%\n%IP1%  %NAME1%\n%IP2%  %NAME2%\n%IP3%  %NAME3%\n%IP4%  %NAME4%\n%IP5%  %NAME5%\n\" >> /etc/hosts"
ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT5% root@localhost "printf \"\n%IP0%  %NAME0%\n%IP1%  %NAME1%\n%IP2%  %NAME2%\n%IP3%  %NAME3%\n%IP4%  %NAME4%\n%IP5%  %NAME5%\n\" >> /etc/hosts"

ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT0% root@localhost "printf \"PS1=\\\"%NAME0% >\\\"\" >> /home/dev/.bashrc"
ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT1% root@localhost "printf \"PS1=\\\"%NAME1% >\\\"\" >> /home/dev/.bashrc"
ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT2% root@localhost "printf \"PS1=\\\"%NAME2% >\\\"\" >> /home/dev/.bashrc"
ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT3% root@localhost "printf \"PS1=\\\"%NAME3% >\\\"\" >> /home/dev/.bashrc"
ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT4% root@localhost "printf \"PS1=\\\"%NAME4% >\\\"\" >> /home/dev/.bashrc"
ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT5% root@localhost "printf \"PS1=\\\"%NAME5% >\\\"\" >> /home/dev/.bashrc"

REM Open connections to containers.
start "%NAME0%" cmd /c ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT0% dev@localhost
start "%NAME1%" cmd /c ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT1% dev@localhost
start "%NAME2%" cmd /c ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT2% dev@localhost
start "%NAME3%" cmd /c ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT3% dev@localhost
start "%NAME4%" cmd /c ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT4% dev@localhost
start "%NAME5%" cmd /c ssh -oStrictHostKeyChecking=no -o IdentitiesOnly=yes -o IdentityFile=%SSH_KEY% -p %PORT5% dev@localhost
