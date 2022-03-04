# Token-crowdsale

This project creates a crowd sale for a token called KaseiCoin. 
In order to make this crowd sale I use 3 contracts. The first one creates a token, the second one manage the crowdSale and the last one link both together under a same deployer.

The token is a ERC20 token without any addition specifications. The crowdsale contract determines the rate of exchange from Eth to KAS, which wallet is going to receive the ETH of the transactions, what are the bounderies of the crowdsale (goal, starting date and closing date) and finally a refund in case the target is not reached.
Finally we can find the link between all the previous contracts in the KaseiCoinCrowdsaleDeployer. Those links are made with the contract addresses. In addition this contract remove the deployers right to mint and gives them only to the Crowdsale.


