# BlockDag

## prerequisites

  - `sudo apt update`
  - `sudo apt install expect`

## setup the wallet and start the node
  
   - `bash blockdag.sh`

## get some balance into wallet

   - `bash refresh_wallet.sh`

## transfer coin utxo to evm

   - `bash transaction.sh amount` 
   - by default amount is 100 for this transaction

## find utxos

   - `./bin/wallet/blockdag-wallet qc getbillbyaddress address`