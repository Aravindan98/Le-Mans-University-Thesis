# Le Mans University - Undergraduate thesis

This repo contains all the code and images for my thesis.

---
## Three methods are explored and compared in this project:
1. The Crank-Nicholson methods as illustrated by Poulsen. Visit the FDM directory for the MATLAB scripts
2. The Deep Galerkin Method. Visit the DGM directory for the iPynb notebooks.
3. The code for the Finite Element Methods was given by Prof. Alexandre Brouste of Le Mans University. It was modified on a case-by-case basis for each of the diffusion processes.

So far the following fokker-planck equation for the following processes have been solved numerically using all three methods.
1. The Ornstein-Uhlenbeck process
2. The Geometric Brownian Motion
3. The Cox-Ingersoll-Ross process

---
## How to use the CCIPL "Waves" cluster? (These instructions are useful for users outside the University of Nantes)
I used a Windows 10 machine, but the instructions for Mac and Linux users is also quite easy.
I followed this [documentation](https://doc.ccipl.univ-nantes.fr/CCIPL-PUBLIC/stable/access/access.html).

The steps are as follows:
1. Fill in the required forms for permission to access the cluster and you will receive two emails. One of the emails contains the link to the documentation while the other contains login credentials (Username and Password) along with this link *jaws.ccipl.univ-nantes.fr*. Since, my internet is not associated with the University of Nantes, I had to connect to proxy server namely "Banzai" to connect to "jaws". > PLEASE ENSURE THAT YOUR INTERNET IS SSH SECURE
2. We use the SSH protocol to establish the remote connection and the first thing to do is to create public and private keys (if it doesn't already exists) using this command: `ssh-keygen`. We can to enter the passphrase (password) or skip it (it really doesn't matter). 
3. 2 keys are generated, in Windows they're named **id_rsa and id_rsa.pub** (private and public key respectively). These keys can be found in the `~/.ssh/` directory. Basically, it's a hidden directory within the home directory called `.ssh`
4. Send the public key back to the CCPIL admin so that they can add it to their list of authorized keys. Once it is done we can now get access to the cluster.
5. To make things a bit more easy, we create an alias file called `config` which should be at the same directory level as our keys (i.e `~/.ssh/`). The contents of the alias files are as follows. If you try to directly copy paste from the 
  ```
  Host Jaws
     Hostname jaws.ccipl.univ-nantes.fr
     User <USERNAME>
     ProxyCommand C:\Windows\System32\OpenSSH\ssh.exe <USERNAME>@banzai.ccipl.univ-nantes.fr -W %h:%p
     ForwardX11 yes
  ```
6. After this step, calling `ssh Jaws` should initiate the connection establishment to the server. Enter the passphrase for the key we created in step 2 and login with the password given by the CCIPL admin. After this, we should be getting the bash shell prompt.
7. Python works, but we won't be able to install any dependencies directly. For that we need to create a virtual environment using the following command: 
```
python3 -m venv \path\<name of virtual environment>
```
8. Type the command: `source <path to virtual environment>\bin\activate`. This activates the virtual environment.
9. You should see something like this in the terminal: `(name of virtual environment) bash>` and now we can download all the required dependencies for our project smoothly.
10. We can do a `pip3 freeze > requirements.txt` to get our list of dependencies in a text file and the next time simple `pip3 requirements.txt` will install everything properly.
11. Any file transfers to or from our local directory involves the sftp protocol. Simply navigate to you local directory and type `sftp Jaws`. This will establish the connnection for file transfers
12. Use `get <filename>` and `put <filename>` to download and upload files from your local directory to the remote directory.

List of useful links:
- [venv for mac/linux](https://www.youtube.com/watch?v=Kg1Yvry_Ydk&t=707s)
- [sftp](https://www.digitalocean.com/community/tutorials/how-to-use-sftp-to-securely-transfer-files-with-a-remote-server) 

   


