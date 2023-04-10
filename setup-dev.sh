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

bitcoin-cli -rpcuser=trustless -rpcpassword=notrespassing stop

mkdir ./bitcoin

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
printf "$CONFIG_BTCD" > ./bitcoin/bitcoin.conf

bitcoind -datadir=./bitcoin --daemon

echo "\n----|Cloning Repos...\n"

git clone https://github.com/TrustlessComputer/trustless-node-easy.git ./trustless-node

cd ./trustless-node

echo "\n----|Starting Trustless node...\n"

BITCOIND_RPC_USERNAME=trustless
BITCOIND_RPC_PASSWORD=notrespassing
BITCOIND_RPC_ENDPOINT=127.0.0.1:8332
TC_BTC_WALLET_NAME=trustless
TC_WALLET_ADDRESS=0x2699ff693FA45234595b6a1CaB6650c849380893

docker compose -f docker-compose-dev.yml up -d