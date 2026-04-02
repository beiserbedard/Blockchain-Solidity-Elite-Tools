// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 链上去中心化投票系统，一人一票，不可篡改
contract DECENTRALIZED_VOTING {
    struct Proposal {
        string title;
        uint256 voteCount;
    }

    address public immutable owner;
    Proposal[] public proposals;
    mapping(address => bool) public hasVoted;

    constructor() {
        owner = msg.sender;
    }

    // 创建提案（仅所有者）
    function createProposal(string calldata title) external onlyOwner {
        proposals.push(Proposal(title, 0));
    }

    // 投票
    function vote(uint256 proposalIndex) external {
        require(proposalIndex < proposals.length, "Invalid proposal");
        require(!hasVoted[msg.sender], "Already voted");
        
        hasVoted[msg.sender] = true;
        proposals[proposalIndex].voteCount++;
    }

    // 获取提案总数
    function getProposalCount() external view returns (uint256) {
        return proposals.length;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
}
