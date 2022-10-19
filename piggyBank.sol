// SPDX-License-Identifier: GPL 3.0
pragma solidity ^0.8.13;

contract piggyBank{
    address payable owner=payable(msg.sender); // owner made payable explicitly
    string name; 
    uint time; // time after which piggybank amount can be accessed
                // local time value is expected

    constructor(string memory _name,uint _time){
        name=_name;
        time=_time;
    }

    function Details() view public returns(address,string memory,uint){
        return(owner,name,time);
    }

    address payable depositor=payable(msg.sender);

    function deposite(uint amount) payable public {
        depositor.transfer(amount);
    }

    function retriveFund() payable public {
        require(msg.sender==owner,"Only owner can retrive Fund");
        require(block.timestamp>=time,"Too early to open Piggybank");
        uint _amount=address(this).balance;
        owner.transfer(_amount);
    }

}