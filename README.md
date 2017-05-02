# HostfileToSSHConfig

Fed up dealing with millions of IP address and wasting time looking for them ?
HostfileToSSHConfig is a very simple bash script that transform your hostfile to an SSH config

To run it :
  - Clone the repo
  - Execute the main.sh
  - ssh your server
  - With the time you've just earned crack open a cold one :beer:

### 1 - Clone the repo
```sh
git clone https://github.com/TimDzik/HostfileToSSHConfig.git
```
### 2 - Execute the main.sh
```sh
./main.sh [YOUR_HOSTFILE_PATH] [YOUR_USER] [YOUR_SSHKEY_PATH] [YOUR_ENV]
```
```[YOUR_HOSTFILE_PATH]``` : The Hostfile you want to convert to SSH Config
```[YOUR_USER]``` : User that will connect the server (root, ubuntu, your current user..)
```[YOUR_SSHKEY_PATH]``` : Where is store your SSH key (Usually in ~/.ssh/mysshkey)
```[YOUR_ENV] ```:  If you want to append the environnement to the server config (eg : staging, production). Setting up [YOUR_ENV] will allow you to have both staging and production in the same config.

Example :
```sh
./main.sh staging ubuntu ~/.ssh/id_rsa staging
```

### SSH your server
```php
Host mysql1
  HostName $MY_IP_ADDRESS
  User ubuntu
  IdentityFile  ~/.ssh/id_rsa
  IdentitiesOnly yes
```

To ssh mysql1 server, no need to check the Hostfile, your host provider or the config you've just generated. Only type in your terminal ssh then tab, It will propose you all servers from your ``~/.ssh/config``

So to SSH mysql run :
```sh
ssh mysql1
```

### With the time you've just earned crack open a cold one :beer:
 :beer:

### Improvements that needs to be done :
[X] Write a basic script
[X] Implement the ENV Variable
[ ] More checking especially if variables are set, and make some of them optionnal (like ENV)
[ ] Add the option to append to current config or overwrite it
[ ] Add some fancy checking and colors
[ ] Add an --help option
[ ] Grab some more info from hostfile (Port, other user different SSH KEY )
