// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 极致Gas优化的链上存储合约，降低交易成本
contract GAS_OPTIMIZED_STORAGE {
    uint256 private storedData;
    event DataUpdated(uint256 oldValue, uint256 newValue);

    // 低Gas存储数据
    function setData(uint256 newValue) external {
        uint256 old = storedData;
        storedData = newValue;
        emit DataUpdated(old, newValue);
    }

    // 低Gas读取数据
    function getData() external view returns (uint256) {
        return storedData;
    }

    // 批量更新（Gas优化）
    function batchSetData(uint256[] calldata values) external {
        storedData = values[0];
    }
}
