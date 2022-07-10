// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;

contract VendingMachine 
{
    address public owner;
    mapping(address => uint) public donutBalances;
    uint public totalSupply = 10000;
    constructor(){
        owner = msg.sender;
        donutBalances[address(this)] = totalSupply;
    }
    function purchase(uint amount) public payable
    {
        require(msg.value >= amount * 2 ether, "You are sending less amount");
        require(donutBalances[address(this)] >= amount, "Not enough donuts");
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;

    }
    function restock(uint amount) public
    {
        require(msg.sender == owner ,"only owner can restock");
        donutBalances[address(this)] += amount;
    }
    function getVendingMachineBalance() public view returns(uint)
    {
        return donutBalances[address(this)];
    }
}
