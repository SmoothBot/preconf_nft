// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Preconf} from "../src/Preconf.sol";

contract PreconfScript is Script {
    Preconf public preconf;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        preconf = new Preconf();

        vm.stopBroadcast();
    }
}
