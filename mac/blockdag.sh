# create wallet private key and public key address for minning address
bash download_wallet.sh
bash wallet.sh

# fetch public address from wallet.txt file
pk_addr=$(tail -n 1 "wallet.txt")

# start the blockdag node
bash node.sh $pk_addr
