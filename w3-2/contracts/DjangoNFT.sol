// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC721/presets/ERC721PresetMinterPauserAutoId.sol";

contract DjangoNFT is ERC721PresetMinterPauserAutoId {
    
    constructor() 
    ERC721PresetMinterPauserAutoId("Django", "Django1212", "https://ichef.bbci.co.uk/news/640/cpsprodpb/174DC/production/_99325459_gettyimages-825838988.jpg")  
    {
        
    }
    
    // This allows the minter to update the tokenURI after it's been minted.
    // To disable this, delete this function.
    function setTokenURI(uint256 tokenId, string memory tokenURI) public {
        require(hasRole(MINTER_ROLE, _msgSender()), "web3 CLI: must have minter role to update tokenURI");
        
        setTokenURI(tokenId, tokenURI);
    }
}