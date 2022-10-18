// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract referendum{
    string public agenda;
    address public manager=msg.sender;

    constructor(string memory _agenda){
        agenda=_agenda;
    }

    uint countYes=0;
    uint countNo=0;
    mapping(address=>bool) voted;

    modifier condition(){
        require(voted[msg.sender]==false,"Already voted");
        require(msg.sender!=manager,"Manager cannot vote");        
        _;
    }

    bool result;
   

    function YES() public condition {
        countYes++;
        voted[msg.sender]=true;
    }

    function NO() public condition {
        countNo++;
        voted[msg.sender]=true;
    }

    function end() public {
        require(msg.sender==manager,"Only manager can call this function");
        require(result==false,"only one time it can be called");
        result=true;
    }

    function endVote(uint a,uint b) internal view returns(string memory) {
        //  result=true;
        if(a>b){
            return('Agenda Agreed');
        }else if(a==countNo){
            return('Equal');
        }else{
            return('Agenda Disagreed');
        }
    }

    function RESULT() public view returns(uint,uint,string memory){
        require(msg.sender==manager,"Only manager can announce result");
        require(result==true,"vote not ended");
        string memory _result=endVote(countYes,countNo);
        return(countYes,countNo,_result);
    } 
}
