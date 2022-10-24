//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract CreateAccount{
    struct User{
        address ID;
        bytes32 password;
    }

    uint userNO;

    constructor(){
        userNO=0;
    }

    mapping(address=>User)user;
    
    function Account() public view returns(address){
        return(msg.sender);
    }

    function register(string memory _password) public {
        require(
            user[msg.sender].ID == address(0x0000000000000000000000000000000000000000),
            "Account already exist"
            );

            // bytes memory R;
            user[msg.sender].ID=msg.sender;
            user[msg.sender].password= bytes32(keccak256(abi.encode(msg.sender,_password)));
    }

    //for testing purpose

    // function display() public view returns(address,bytes32){ 
    //     return(
    //         user[msg.sender].ID,user[msg.sender].password);
    // }
}
