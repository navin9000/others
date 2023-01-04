//SPDX-License-Identifier:UNLICENSED
pragma solidity 0.8.7;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "src/quillCTF/challenge4.sol";
import "src/quillCTF/challenge4Attack.sol";

contract TestChallenge4 is Test {
    safeNFT public challenge;
    Attack public attack;

    ///setup
    constructor() {
        challenge = new safeNFT("Purple_Calender", "PC", 10000000000000000);
        vm.deal(address(this), 3 ether);
        attack = new Attack{value: 1 ether}(address(challenge));
    }

    ///Claiming multiple NFTs for the price of one
    function test_claim() public {
        attack.Buy();
        attack.claimNFT();
        emit log_named_uint(
            "balanceOf attack",
            challenge.balanceOf(address(attack))
        );
        assertEq(challenge.balanceOf(address(attack)), 100);
    }
}
