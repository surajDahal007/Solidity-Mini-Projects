//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract toDo{
 
    struct user{
        address participant;
        string [] Task;
        string [] completeTask;
    }

    // user struct variable
    user public u; 

    // to initialise actual participant
    constructor(address _user){
        u.participant=_user;
    }

    modifier onlyUser(){
        require(msg.sender==u.participant,"Only users can view their details");
        _;
    }

    
    function addTask(string memory _task) public onlyUser {
        u.Task.push(_task);
    }

    function displayTask() public view onlyUser returns(string[] memory){
            return(u.Task);
    }

    function taskCompleted(uint _index) public onlyUser {
        u.completeTask.push(u.Task[_index]);
    }

    function displayCompleted() public view onlyUser returns(string [] memory){
        return(u.completeTask);
    }
}