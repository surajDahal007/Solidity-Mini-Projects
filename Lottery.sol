// TIME STAMP CAN BE ADDED
// LOTTERY WINNER CALCULATION ALOGORITHM CAN BE CHANGED

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract lottery{
    address payable public manager=payable(msg.sender);
    string name;
    uint price;
    string details;
    bool isCalculated;
    uint count=0;
    uint x;
    bool isClaimed;
    // bool ended;
    // bool isDisplayed;

    // constructor to initialise lottery
    constructor(string memory _name,uint _price,string memory _details){
        name=_name;
        price=_price;
        details=_details;
    }

    address[] participant; // participant array
    mapping(address=>bool) public bought;

    function aboutLottery() public view returns(string memory,uint,string memory) {
        return(name,price,details);
    }

    // to buy tickets for lottery
    function buyTicket() public payable {
        address payable _contributor=payable(msg.sender);

        require(msg.sender!=manager,"Manager cannot buy ticket");
        require(msg.value>price,"Insufficient amount");
        require(bought[msg.sender]==false,"you already bought ticket");
        _contributor.transfer(price);
        count++;
        participant.push(msg.sender);
        bought[msg.sender]=true;
    }


    // calculate lottery
    function calculate() public {
        require(msg.sender==manager,"Only manager can access calculate result");
        require(isCalculated==false,"Already calculated");
        x=(count+1)/count;
        isCalculated=true;
    }

    // display Winner
    function display() public view returns(address){
        require(msg.sender==manager,"Only manager can acces calculate result");
        require(isCalculated==true,"Winner must be calculated first");
        return(participant[x]);
    }

    // winner draws back amount from contract
    function claimFund() public payable{
        require(msg.sender==participant[x]);
        require(isClaimed==false,"Fund already claimed");
        
        // to transfer amount from contract to winner

        uint _amount=address(this).balance;
        address payable _contributor=payable(msg.sender);
        _contributor.transfer(_amount);
        isClaimed=true;
    }
}