 pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Preconf} from "../src/Preconf.sol";

contract MintScript is Script {
    function setUp() public {}

    function run() public {
        // This will create but not send the transaction
        
        address NFT_ADDRESS = 0x03eAd45f726998F9B555869E3AF8996a92044969;
        address recipient = 0x3B16821A5dBBFF86E4a88eA0621EC6be016cd79A;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        Preconf nft = Preconf(NFT_ADDRESS);

        vm.broadcast();
        nft.mint(recipient);

        bytes memory mintCalldata = abi.encodeWithSignature(
            "mint(address)", 
            recipient
        );

        // Get the nonce
        uint64 nonce = vm.getNonce(vm.addr(privateKey));
        
        // Construct the raw transaction
        bytes memory rawTx = abi.encode(
            nonce,                          // nonce
            tx.gasprice,                    // gas price
            100000,                         // gas limit
            NFT_ADDRESS,                    // to
            0 ether,                        // value
            mintCalldata                    // data
        );

        // Sign the transaction
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, keccak256(rawTx));

        console2.log("Raw Transaction:");
        console2.logBytes(rawTx);
        console2.log("\nSignature Components:");
        console2.log("v:", v);
        console2.log("r:", vm.toString(r));
        console2.log("s:", vm.toString(s));
    }
}