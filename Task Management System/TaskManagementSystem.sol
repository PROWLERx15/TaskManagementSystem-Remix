// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {TaskStorage} from "./Task.sol";

contract TaskManagementSystem
{

    TaskStorage[] public ListOfTaskContract;

    mapping (string=>uint256) public nameToTaskIndex;

    function createTaskManagmentContract(string memory name) public 
    {
        TaskStorage newTaskStorageContract = new TaskStorage();
        ListOfTaskContract.push(newTaskStorageContract);
        nameToTaskIndex[name] = ListOfTaskContract.length-1;
    }

    function getTaskManagementContract(uint256 _taskStorageIndex, string memory _taskdescription,uint256 _taskdeadline) public 
    {
        ListOfTaskContract[_taskStorageIndex].createTask(_taskdescription,_taskdeadline);
    }

    function getTaskDetailsInContract(string memory _name,uint256 taskNo) public view returns (string memory,uint256,string memory) 
    {
        uint256 taskIndex = nameToTaskIndex[_name];
        TaskStorage getTask = ListOfTaskContract[taskIndex];
        return getTask.getTaskDetails(taskNo);
    }

    function getTaskStatusInContract(string memory _name,uint256 taskNo) public view returns (string memory)
    {
        uint256 taskIndex = nameToTaskIndex[_name];
        TaskStorage getTaskStatus = ListOfTaskContract[taskIndex];
        return getTaskStatus.showTaskStatus(taskNo);
    }

    function updateTaskStatusInContract(string memory _name,uint256 taskNo, uint256 updatedStatus) public 
    {
        uint256 taskIndex = nameToTaskIndex[_name];
        TaskStorage updateTaskStatus = ListOfTaskContract[taskIndex];
        updateTaskStatus.updateTaskStatus(taskNo,updatedStatus);
    }

    function DisplayTasks(string memory _name) public view returns (string[] memory)
    {
        uint256 ContractIndex = nameToTaskIndex[_name];
        TaskStorage getList = ListOfTaskContract[ContractIndex];
        return getList.DisplayTasks();
    }


}