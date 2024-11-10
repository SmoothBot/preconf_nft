// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Preconf} from "../src/Preconf.sol";

contract PreconfTest is Test {
    Preconf public nft;
    address owner;
    address user;
    string constant TEST_URI = "ipfs://QmTest";

    function setUp() public {
        owner = makeAddr("owner");
        user = makeAddr("user");
        
        vm.prank(owner);
        nft = new Preconf();
    }

    function test_InitialState() public {
        assertEq(nft.name(), "Preconf");
        assertEq(nft.symbol(), "BASED");
        assertEq(nft.isMinted(), false);
    }

    function test_OnlyOwnerCanMint() public {
        vm.prank(user);
        vm.expectRevert();
        nft.mint(user);
    }

    function test_SuccessfulMint() public {
        vm.prank(owner);
        nft.mint(user);

        assertEq(nft.ownerOf(0), user);
        assertEq(nft.isMinted(), true);
        assertEq(nft.balanceOf(user), 1);
    }

    function test_CannotMintTwice() public {
        vm.startPrank(owner);
        
        nft.mint(user);
        vm.expectRevert();
        nft.mint(user);
        
        vm.stopPrank();
    }

    function test_TokenURIManagement() public {
        vm.startPrank(owner);
        
        // Mint first
        nft.mint(user);
        
        // Set and verify URI
        nft.setTokenURI(TEST_URI);
        assertEq(nft.tokenURI(0), TEST_URI);
        
        vm.stopPrank();
    }

    function test_CannotGetURIForNonexistentToken() public {
        vm.expectRevert();
        nft.tokenURI(0);
    }

    function test_OnlyOwnerCanSetURI() public {
        vm.prank(owner);
        nft.mint(user);

        vm.prank(user);
        vm.expectRevert();
        nft.setTokenURI(TEST_URI);
    }
} 