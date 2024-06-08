# CryptoArtGallery Contract

## Overview

The `CryptoArtGallery` contract is an ERC20 token-based platform that allows users to buy, sell, and redeem tokens for different types of digital art pieces. The contract includes functionalities for minting new tokens, transferring tokens, checking token balances, and burning tokens.

## Token Details

- **Name**: CryptoArtGallery
- **Symbol**: CAG

## Features

1. **Minting Tokens**: The owner can mint new tokens and distribute them to users.
2. **Transferring Tokens**: Users can transfer their tokens to other users.
3. **Buying Art Pieces**: Users can redeem their tokens to buy different types of art pieces.
4. **Selling Art Pieces**: Users can sell their owned art pieces back to the platform.
5. **Checking Token Balance**: Users can check their token balance at any time.
6. **Burning Tokens**: Users can burn their tokens that are no longer needed.

## Art Pieces

The platform supports the following types of art pieces with their respective prices:

- **Portrait**: 10,000 CAG
- **Landscape**: 15,000 CAG
- **Abstract**: 5,000 CAG
- **Sculpture**: 20,000 CAG

## Functions

### Only Owner Functions

- **mintTokens(address to, uint256 amount)**: Mint new tokens and distribute them to a specified address.
- **withdrawArtistFunds(uint256 amount)**: Withdraw funds from the contract's balance to the owner's address.

### Public Functions

- **transferTokens(address to, uint256 amount)**: Transfer tokens to another user.
- **buyArtPiece(ArtPieces pieceType)**: Redeem tokens to buy an art piece.
- **sellArtPiece(ArtPieces pieceType)**: Sell an owned art piece back to the platform.
- **checkTokenBalance(address account) public view returns (uint256)**: Check the token balance of a specified address.
- **redeemArtPiece(ArtPieces pieceType)**: Redeem tokens to buy an art piece.
- **burnTokens(uint256 amount)**: Burn tokens that are no longer needed.
- **getOwnedArtPiecesAmount(ArtPieces pieceType) public view returns (uint256)**: Get the number of owned art pieces of a specific type.
- **valueArtPiece(ArtPieces pieceType) external view returns (uint256)**: Get the price of a specific art piece type.

## Events

- **TokensBurned(address indexed burner, uint256 amount)**: Emitted when tokens are burned.
- **ArtPieceBought(address indexed buyer, ArtPieces pieceType, uint256 piecePrice)**: Emitted when an art piece is bought.
- **ArtPieceSold(address indexed seller, ArtPieces pieceType, uint256 piecePrice)**: Emitted when an art piece is sold.
- **ArtPieceRedeemed(address indexed redeemer, ArtPieces pieceType)**: Emitted when an art piece is redeemed.

## Usage

### Minting Tokens

```solidity
function mintTokens(address to, uint256 amount) external onlyOwner {
    _mint(to, amount);
}
