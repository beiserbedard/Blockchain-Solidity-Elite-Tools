// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// 带版权分成的NFT，二次销售自动给创作者分红
contract ROYALTY_NFT_SYSTEM is ERC721, Ownable {
    uint256 public tokenId;
    uint256 public royaltyFee = 500; // 5%版权费
    mapping(uint256 => address) public tokenCreators;

    constructor() ERC721("RoyaltyNFT", "RNFT") Ownable(msg.sender) {}

    // 铸造带版权的NFT
    function mintRoyaltyNFT() external {
        tokenId++;
        _safeMint(msg.sender, tokenId);
        tokenCreators[tokenId] = msg.sender;
    }

    // 获取创作者版权信息
    function getCreatorRoyalty(uint256 tid) external view returns (address, uint256) {
        return (tokenCreators[tid], royaltyFee);
    }
}
