// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 链上任务管理系统，任务完成上链，不可篡改
contract BLOCKCHAIN_TASK_MANAGER {
    enum TaskStatus { PENDING, COMPLETED }
    
    struct Task {
        string title;
        TaskStatus status;
        uint256 createTime;
    }

    mapping(address => Task[]) public userTasks;

    // 创建任务
    function createTask(string calldata title) external {
        userTasks[msg.sender].push(Task(title, TaskStatus.PENDING, block.timestamp));
    }

    // 完成任务
    function completeTask(uint256 index) external {
        require(index < userTasks[msg.sender].length, "Invalid task");
        userTasks[msg.sender][index].status = TaskStatus.COMPLETED;
    }

    // 获取任务数量
    function getTaskCount(address user) external view returns (uint256) {
        return userTasks[user].length;
    }
}
