// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// 限量版NFT铸造系统，带白名单+最大铸造限制
contract NFT_MINT_SYSTEM is ERC721, Ownable {
    uint256 public tokenIdCounter;
    uint256 public constant MAX_SUPPLY = 1000;
    mapping(address => bool) public whiteList;

    constructor() ERC721("BlockchainRandomNFT", "BRNFT") Ownable(msg.sender) {}

    // 添加白名单
    function addToWhiteList(address user) external onlyOwner {
        whiteList[user] = true;
    }

    // 白名单铸造NFT
    function mintNFT() external {
        require(whiteList[msg.sender], "Not in whitelist");
        require(tokenIdCounter < MAX_SUPPLY, "Max supply reached");
        
        tokenIdCounter++;
        _safeMint(msg.sender, tokenIdCounter);
    }

    // 获取当前总供应量
    function getTotalSupply() external view returns (uint256) {
        return tokenIdCounter;
    }
}
