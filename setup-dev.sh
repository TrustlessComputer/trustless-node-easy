#!/bin/sh
echo '
            .+%-                                                                                                        
          .*@@@@%=                                                                                                      
        .+@@@@@@@@%-                                                                                                    
        @@@@@+:#@@@@+               :::::::: .::::.    .:     .:.   .:::  .:::::::. ::       .:::::::.   :::.     :::.  
        @@@=    .#@@+              .**#@@**+ *@%*#@@-  #@.    -@- .%@*+#@--**%@%**: @@       +@%*****: =@%+*#%  *@*+*%* 
        @+  ----: :#+                 :@#    *@-  .@@  #@.    -@- =@*        +@-    @@       +@=       @@-     .@%.     
             :-.                      :@#    *@+:-#@*  #@.    -@-  +%@%+:    +@-    @@       +@%####=  .*@@#+.  -#@@*-  
     :#.             =+.              :@#    *@#*%@*   *@:    =@-     :#@+   +@-    @@       +@+.....     .-%@.    .+@% 
   -%@@.             +@@+.            :@#    *@-  *@*  :@@=--+@#  +=-:-#@=   +@-    @@-----: +@*-----:.*=::-%@ -+-::+@# 
 :#@@@@.             +@@@@+.          .+=    -+.   -+-   -+**+:   .=+**=.    -+:    +++++++- -+++++++- -=**+=  .-+**+:  
#@@@@@@.             +@@@@@@-                                                                                           
=@@@@@@.             +@@@@@@            :::.      .:::     .           .  ::::.   ::     .: .:::::::  :::::::. ::::.    
 @@@@@@.             +@@@@@+         -%@#**%%  .*@#**#@#-  =#.       .%- -@%**%@+ #@.    +@--**%@#**:.@%*****- #@#*#@%- 
 =@@@@@.             +@@@@@         +@*       -@#.     *@+ =@@=     =@@- -@+   %@:#@.    +@-   =@-   .@+       #@.  :@@ 
  %@@@@.             +@@@@+         @@.       %@:       %@.=@#@#   #@*@- -@#--+@% #@.    +@-   =@-   .@@%%%%%  #@=--#@+ 
  :%@@@.             +@@@*          %@-       *@+      :@% =@=.#@+@# -@- -@%++=:  #@:    *@-   =@-   .@*       #@*+%@=  
    =@@.             +@#:            *@*-::=*  +@%=-:=#@#  =@=  +@=  -@- -@+      :@%=:-*@#    =@-   .@#:::::. #@.  *@+ 
      +.             --               .=+**+-    -+**+=.   -*:       :*: :+-        -+**+:     -*:   .*******= =*.   =*:
       .-:         -:.                                                                                                  
    .-++=--:.....-=-=+=:                                                                                                
'

echo "\n----|Installing Docker...\n"

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh

echo "\n----|Installing dependencies...\n"

sudo apt-get -y install build-essential libtool autotools-dev autoconf libssl-dev libboost-all-dev

echo "\n----|Installing Bitcoin Core...\n"
sudo add-apt-repository -y ppa:luke-jr/bitcoincore
sudo apt-get update
sudo apt-get -y install bitcoin-qt bitcoin-tx bitcoind 

bitcoin-cli -rpcuser trustless -rpcpassword notrespassing stop

CONFIG_BTCD=$(cat <<EOF
rpcuser=trustless
rpcpassword=notrespassing
rpcallowip=127.0.0.1
regtest=1
server=1
[regtest]
rpcport=8332
EOF
)
printf "$CONFIG_BTCD" > ~/.bitcoin/bitcoin.conf

bitcoind --daemon

echo "\n----|Cloning Repos...\n"

git clone https://github.com/TrustlessComputer/trustless-node-easy.git ./trustless-node

cd ./trustless-node

git clone https://github.com/TrustlessComputer/tc-prebuilds.git ./tc-prebuilds

echo "\n----|Starting Trustless node...\n"

docker compose -f docker-compose-dev.yml up -d