//SPDX-License-Identifier:UNLICENSED
pragma solidity 0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DamnValuableToken is ERC20 {
    constructor() ERC20("purple_calender", "PC") {
        _mint(msg.sender, 1000100 * 10 ** 18);
    }
}
