// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Counter is ERC721, Ownable {
    bool public isMinted;
    string private _tokenURI;

    constructor() ERC721("UniqueCounter", "UCTR") Ownable(msg.sender) {}

    function mint(address to) public onlyOwner {
        require(!isMinted, "NFT already minted");
        _safeMint(to, 0); // Token ID will be 0 since it's a 1-of-1
        isMinted = true;
    }

    function setTokenURI(string memory newTokenURI) public onlyOwner {
        _tokenURI = newTokenURI;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireMinted(tokenId);
        return _tokenURI;
    }
}
