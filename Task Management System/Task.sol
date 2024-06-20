// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract TaskStorage
{

    struct Task
    {
        string  Description;
        address Creator;
        uint256 Deadline;
        address Address;
        Status Status;
    }

    enum Status { Pending,InProgress,Completed }

    uint256 taskCount = 0;

    Task[]  ListOfTasks;
    
    mapping (uint256 => Task)  NoOfTask;

    Status taskStatus;

    function createTask(string memory _description,uint256 _deadline) public   
    {
        Task storage newTask = ListOfTasks.push();   // Create new Task in array of struct named - ListOfTasks
        newTask.Description = _description;
        newTask.Deadline = _deadline;
        newTask.Address = msg.sender;
        newTask.Status = Status.Pending;   // Make The Task Status of newTask = Pending
    }

    function getTaskDetails(uint256 _taskId) public view returns (string memory,uint256,string memory)
    {
        Task memory showDetails = ListOfTasks[_taskId];
        return (showDetails.Description,showDetails.Deadline,showTaskStatus(_taskId));
    }

    function showTaskStatus(uint256 _taskId) public view returns (string memory)
    {
        Task memory TaskStatus = ListOfTasks[_taskId];
        uint256 checkStatus = uint256(TaskStatus.Status);
        if (checkStatus == 1) {
            return 'InProgress';
        }
        if (checkStatus == 2) {
            return 'Completed';
        }
        return 'Pending';
    }

    function updateTaskStatus(uint256 _taskId, uint256 updatedStatus) public 
    {
        Task storage TaskStatus = ListOfTasks[_taskId];
        if (updatedStatus == 1) {
            TaskStatus.Status = Status.InProgress;
        }
        if (updatedStatus == 2) {
            TaskStatus.Status = Status.Completed;
        }
    }
    

    function DisplayTasks() public view  returns (string[] memory)
    {
        string[] memory DescriptionOfAllTasks = new string[](ListOfTasks.length);
        for (uint256 i = 0; i<ListOfTasks.length; i++)
        {
            DescriptionOfAllTasks[i] = ListOfTasks[i].Description;
        }
        return DescriptionOfAllTasks;
    }

}