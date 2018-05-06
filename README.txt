README

SmartBets.io
Matthew Saltzman, John Kuhn, Harry Luo

About us:
Our project is a web based League of Legends sports betting application!
Deployment details are below.

Disclaimer:
Because we are leveraging the Riot API, our API key is only valid every 24 hours.
Therefore testing the smart contract will probably throw an unauthorized access
error on the back end. We will try our best to keep the API key valid every day
but if you want to make sure it's ready on deployment let one of us know! Realistically
you can honestly shoot me a text at (845-271-9734) or an email at (msaltzm5@jhu.edu) and
I'll respond promptly to make sure it's updated for your testing. In a professional
setting our API key would be valid at all times, obviously. 

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
			'truffle migrate --compile-all --reset'
				THIS WILL TAKE SEVERAL MINUTES AND REQUIRES THAT:
					1. YOU ARE RUNNING YOUR RINKEBY NODE
					2. THE FIRST TRUFFLE ACCOUNT YOU HAVE IS FUNDED AND UNLOCKED
          3. YOU HAVE CHANGED THE IMPORT STATEMENTS IN Outcome.sol AND Dragon.sol
          TO YOUR RESPECTIVE PATH TO THE ORACLIZE API IN NODE MODULES
          4. YOU SHOULD SEE COMPILATION WARNINGS FOR ORACLIZE, THIS IS FINE
6. Build web application
		Use 'npm run dev' to spin up the web application
		Go to localhost:8080 to interact with the smart contract betting web application
			When interacting with the web application:
				Use metamask extension for chrome and have funded accounts associated with the metamask

Congratulations! You have your very own Esports Smart Contract Betting Web Application!

If any errors or difficulty is experienced in deploying the application there is
a good chance it is neither our fault or yours since we rely on the Testnet.
In the event of errors please reach out to jkuhn8@jhu.edu for assistance in deploying.
