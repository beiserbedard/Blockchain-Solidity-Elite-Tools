// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 多签钱包，2/3签名即可执行转账，企业级安全
contract MULTI_SIGN_WALLET {
    address[3] public owners;
    uint256 public requiredSign = 2;
    mapping(uint256 => mapping(address => bool)) public confirmations;
    struct Transaction { address to; uint256 value; bool executed; }
    Transaction[] public transactions;

    constructor(address[3] memory _owners) {
        owners = _owners;
    }

    // 提交交易
    function submitTransaction(address to, uint256 value) external onlyOwner returns (uint256) {
        uint256 txId = transactions.length;
        transactions.push(Transaction(to, value, false));
        return txId;
    }

    // 确认交易
    function confirmTransaction(uint256 txId) external onlyOwner {
        confirmations[txId][msg.sender] = true;
        if (getConfirmationCount(txId) >= requiredSign) {
            executeTransaction(txId);
        }
    }

    // 执行交易
    function executeTransaction(uint256 txId) internal {
        Transaction storage txn = transactions[txId];
        require(!txn.executed, "Executed");
        txn.executed = true;
        payable(txn.to).transfer(txn.value);
    }

    function getConfirmationCount(uint256 txId) public view returns (uint256) {
        uint256 count;
        for (uint i=0; i<3; i++) if (confirmations[txId][owners[i]]) count++;
        return count;
    }

    modifier onlyOwner() {
        bool isOwner;
        for (uint i=0; i<3; i++) if (msg.sender == owners[i]) isOwner = true;
        require(isOwner, "Not owner");
        _;
    }
}
