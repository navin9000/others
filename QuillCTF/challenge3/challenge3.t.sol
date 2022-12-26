// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "src/quillCTF/challenge3.sol";

contract Challenge3 is Test {
    Confidential challenge;
    bytes32 aliceHash;
    bytes32 bobHash;
    bytes32 private_key;

    constructor() {
        challenge = new Confidential();
        aliceHash = challenge.hash(private_key, challenge.ALICE_DATA());
        bobHash = challenge.hash(private_key, challenge.BOB_DATA());
    }

    function test_hashs() public {
        emit log_bytes32(aliceHash);
        emit log_bytes32(bobHash);
    }

    function test_aliceBobHash() public {
        bytes32 bothHash = challenge.hash(aliceHash, bobHash);
        emit log_bytes32(bothHash);
        bool val = challenge.checkthehash(bothHash);
        assertTrue(val);
    }
}
