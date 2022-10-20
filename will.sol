// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

// Create Will of GrandFather

contract Will{
    // Amount Grandfather will give
    uint fortune;
    // Grandfather dead or not
    bool deceased;
    // Address of grandfather
    address owner;

    constructor() payable {
        owner = msg.sender; // owner is representaion of who is calling this address
        // owner is person executing contract      
        fortune = msg.value;
        // sender represents address
        // value represent amount of ether
        deceased = false;
    }

    // modifier so the only person who can call the contract is the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;      // shift to actual function 
    }
    // modifier so that we only allocate funds is deceased = true
    modifier mustBeDeceased{
        require(deceased == true);
        _;
    }
    // List of family wallets
    address payable [] familyWallets;

    // Map through inheritance
    mapping(address => uint) inheritance;

    // set inheritance for each address // will writing
    function setInheritance(address payable wallet,uint amount) public onlyOwner{
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }
    // Automate family member payments
    function payout() private mustBeDeceased{
        for(uint i = 0; i < familyWallets.length;i++){
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    function isDeceased() public onlyOwner{
        deceased = true;
        payout();
    }
}
