// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;
// Building Own Coin
contract XDCoin {
    // Contract allows only the creator to make new coins
    // anyone can send receive coins
    address public minter;
    mapping (address => uint) balance;
    // Event sent
    event Sent(address from, address to, uint amount);
    // Only runs when we deploy contract
    constructor(){
        minter = msg.sender;
    }
    // make new coins and send them to an address
    // only owner can send these coins
    function mint(address receiver , uint amount) public {
        require(msg.sender == minter);
        balance[receiver] += amount;
    }
    error insufficientBalance(uint requested, uint available);
    // Function to send any amount of coins
    function send(address receiver , uint amount) public  {
        if(balance[msg.sender] < amount){
            revert insufficientBalance({
                requested : amount ,
                available : balance[msg.sender]
            });
        }
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

    function balances() public view returns(uint) {
        return balance[msg.sender];
    }
}
