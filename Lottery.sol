// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Lottery
{
    address public manager;     //manager's address
    address payable[] public participants;  //receive ethers

    constructor(){
        manager = msg.sender;   //account deploying contract
        //msg.sender is global var
    }

    receive() external payable
    {
        require(msg.value == 1 ether);  //if this is true then only next will execute
        participants.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint)
    {
        require(msg.sender == manager);
        return address(this).balance;
    }
    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));           //keccak is hashing algo
        //generates a random number
    }
    function selectWinner() public
    {
        require(msg.sender == manager);
        require(participants.length >= 3);
        uint rand = random();
        address payable winner;
        uint index = rand%participants.length;
        winner = participants[index];
        winner.transfer(getBalance());
        participants = new address payable[](0);
    }
}