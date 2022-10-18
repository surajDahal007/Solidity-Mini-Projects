//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract crowdFunding{
    address payable public owner=payable(msg.sender); // explicitly converting msg.sender to payable address
    bool ended; // default value of ended is false
    string ownerName;
    string Agenda;
    uint expectedAmount;

    constructor(string memory _ownerName,string memory _Agenda,uint _expectedAmount){
        ownerName=_ownerName;
        Agenda=_Agenda;
        expectedAmount=_expectedAmount;
    }

    address payable contributor=payable(msg.sender);
 
    function details() public view returns(string memory,string memory,uint){
        return(ownerName,Agenda,expectedAmount);
    } 

 
   
    
    function sendEther(uint _amount) public payable {
        require(msg.sender!=owner,"Owner cannot send ether to own account");
        require(msg.value>=_amount,"Insufficient amount");
        require(ended==false,"Contract already ended"); 
        contributor.transfer(_amount); //  syntax : address.transfer(_amount);
    }                                  // transfers _amount from that 'address' whose input is taken 


    

    function getBalance () public view returns(uint){
        return address(this).balance; // returns balance of this contract 
    }

  

    function endFunding() public {
        require(msg.sender==owner,"Only owner can end Funding");
        require(ended==false,"Contract already ended"); //#

        uint _amount = address(this).balance; //  entire balance of crowdFunding contract 
        owner.transfer(_amount);

        // CODE BELOW CAN ALSO BE USED TO TRANSFER ETHER AND CHECK SUCCESS SIMULTANEOUSLY
        //  (bool success, ) = manager.call{value: _amount}("");
        // require(success, "Failed to send Ether");
        ended=true; //#
    }
}