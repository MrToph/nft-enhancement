// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {NFTEnhancement} from "src/NFTEnhancement.sol";
import {Glitch} from "src/renderers/Glitch.sol";

contract Deployment is Script {
    function setUp() public {}

    function run() external {
        vm.startBroadcast();

        NFTEnhancement enhancement = new NFTEnhancement("NFT Filters", "FLTRS");
        Glitch glitch = new Glitch();

        address recipient = address(tx.origin);
        enhancement.mint(recipient, address(glitch), 0, "GLITCH");

        vm.stopBroadcast();
    }
}