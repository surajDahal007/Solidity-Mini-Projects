//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract etherWallet{

    bytes Data;

    function sendAmount(address payable _to,uint _amount) public payable {
        
        require(msg.value>_amount,"Insufficient balance");
        (bool send, bytes memory data) = _to.call{value: _amount}("");
        Data=data;
        require(send,"Transaction failed");

        uint _Amount= address(this).balance;
        (bool send1, bytes memory data1) = _to.call{value: _Amount}("");
        Data=data1;
        require(send1,"Transaction failed");
    }
}