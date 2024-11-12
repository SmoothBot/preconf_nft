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
        preconf.setTokenURI("ipfs://QmP2CnQRXdz415rEnjsQSbGQpVL6zV9b6goW9m6wW9L7p8");

        vm.stopBroadcast();
    }
}
