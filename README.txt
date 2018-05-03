README

SmartBets.io
Matthew Saltzman, John Kuhn, Harry Luo

About us:
Our project is a web based League of Legends sports betting application!
Deployment details are below.

Deployment Steps:
1. Install geth, this will be used to interact with ethereum blockchains
        Mac:
           'brew tap ethereum/ethereum'
           'brew install ethereum'
        Ubuntu:
        	'sudo apt-get install software-properties-common'
        	'sudo add-apt-repository -y ppa:ethereum/ethereum'
        	'sudo apt-get update'
        	'sudo apt-get install ethereum'
2. Run a Rinkeby Node 
	    During this process we'll be interacting with the Rinkeby testnet.
	    In order to do this you'll need to be running a node on Rinkeby during
	    the development process. In order to do this open up a new terminal window
	    and run the command below:
	        'geth --rinkeby --syncmode "fast" --rpc --rpcapi db,eth,net,web3,personal --cache=1024  --rpcport 8545 --rpcaddr 127.0.0.1 --rpccorsdomain "*"'
3. Install truffle
		'npm install -g truffle'
4. Ensure ethereum account on your truffle is funded and unlocked, this allows us to deploy our smart contract
		Use 'truffle console' to access the truffle console:
			'web3.personal.newAccount('verystrongpassword')'
			'web3.eth.getBalance('newAccountAddress')'
				Ensure this account is funded using the Rinkeby Testnet Faucet ('https://faucet.rinkeby.io/')
			'web3.personal.unlockAccount('newAccountAddress', 'verystrongpassword', 15000)'
5. Deploy smart contract
		From base directory of this repo run
			'truffle migrate'
				THIS WILL TAKE SEVERAL MINUTES AND REQUIRES THAT:
					1. YOU ARE RUNNING YOUR RINKEBY NODE
					2. THE FIRST TRUFFLE ACCOUNT YOU HAVE IS FUNDED AND UNLOCKED
6. Build web application
		Use 'npm run dev' to spin up the web application
		Go to localhost:8080 to interact with the smart contract betting web application
			When interacting with the web application either:
				Use a Dbrowser such as mist
				Use metamask for chrome an have funded wallets associated with the metamask 

Congratulations! You have your very own Esports Smart Contract Betting Web Application!