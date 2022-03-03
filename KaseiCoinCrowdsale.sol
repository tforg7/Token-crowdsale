pragma solidity ^0.5.5;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";



// The KaseiCoinCrowdsale contract organizes the crowdsale and fix some boundaries to the contract:
contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale
{ 
    // Provide parameters for all of the features of your crowdsale.
    constructor(
        uint256 rate,
        address payable wallet,
        KaseiCoin token,
        uint goal,
        uint open,
        uint close
    ) 
        public
        Crowdsale(rate, wallet, token)
        CappedCrowdsale(goal)
        TimedCrowdsale(open, close)
        RefundableCrowdsale(goal)
        
        {
            // constructor can stay empty
        }
}


contract KaseiCoinCrowdsaleDeployer {
    // Create an `address public` for variable containing the addresses to the other contracts.
    address public kasei_token_address;
    address public kasei_crowdsale_address;

    constructor(
        string memory name,
        string memory symbol,
        address payable wallet,
        uint goal
    ) 
        public 
        {
        // Create a new instance of the KaseiCoin contract, with 0 initial supply
        KaseiCoin token = new KaseiCoin(name, symbol , 0);
        
        // Assign the token contract’s address to the `kasei_token_address` variable.
        kasei_token_address = address(token);

        // Create a new instance of the `KaseiCoinCrowdsale` contract, with a rate of 25KAI for 1ETH and a Wallet of choice as ETH manager
        KaseiCoinCrowdsale kaseiCrowdSale = new KaseiCoinCrowdsale(25, wallet, token, goal, now, now + 24 weeks);
            
        // Aassign the `KaseiCoinCrowdsale` contract’s address to the `kasei_crowdsale_address` variable.
        kasei_crowdsale_address = address(kaseiCrowdSale);

        // Set the `KaseiCoinCrowdsale` contract as a minter
        token.addMinter(kasei_crowdsale_address);
        
        // Have the `KaseiCoinCrowdsaleDeployer` renounce its minter role.
        token.renounceMinter();
        }
}
