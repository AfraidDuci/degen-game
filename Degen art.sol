// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CryptoArtGallery is ERC20 {
    enum ArtPieces { Portrait, Landscape, Abstract, Sculpture }
    address public owner;

    mapping(ArtPieces => uint256) public piecePrices;
    mapping(address => mapping(ArtPieces => uint256)) public ownedArtPieces;

    constructor() ERC20("CryptoArtGallery", "CAG") {
        owner = msg.sender;
        piecePrices[ArtPieces.Portrait] = 10000;
        piecePrices[ArtPieces.Landscape] = 15000;
        piecePrices[ArtPieces.Abstract] = 5000;
        piecePrices[ArtPieces.Sculpture] = 20000;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    event TokensBurned(address indexed burner, uint256 amount);
    event ArtPieceBought(address indexed buyer, ArtPieces pieceType, uint256 piecePrice);
    event ArtPieceSold(address indexed seller, ArtPieces pieceType, uint256 piecePrice);
    event ArtPieceRedeemed(address indexed redeemer, ArtPieces pieceType);

    // Function to mint tokens; only the owner can call this function
    function mintTokens(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Function to transfer tokens between players
    function transferTokens(address to, uint256 amount) public {
        _transfer(msg.sender, to, amount);
    }

    // Function to redeem tokens for an art piece in the in-game store
    function buyArtPiece(ArtPieces pieceType) public {
        uint256 piecePrice = piecePrices[pieceType];
        require(balanceOf(msg.sender) >= piecePrice, "Insufficient balance to buy the art piece");

        _transfer(msg.sender, address(this), piecePrice);
        ownedArtPieces[msg.sender][pieceType] += 1;

        emit ArtPieceBought(msg.sender, pieceType, piecePrice);
    }

    // Function to sell an art piece back to the platform
    function sellArtPiece(ArtPieces pieceType) public {
        require(ownedArtPieces[msg.sender][pieceType] > 0, "You do not own this type of art piece");

        uint256 piecePrice = piecePrices[pieceType];

        ownedArtPieces[msg.sender][pieceType] -= 1;
        _transfer(address(this), msg.sender, piecePrice);

        emit ArtPieceSold(msg.sender, pieceType, piecePrice);
    }

    // Function to check the balance of tokens
    function checkTokenBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    // Function to redeem art pieces using tokens
    function redeemArtPiece(ArtPieces pieceType) public {
        require(balanceOf(msg.sender) >= piecePrices[pieceType], "Insufficient balance to redeem art piece");

        buyArtPiece(pieceType);

        emit ArtPieceRedeemed(msg.sender, pieceType);
    }

    // Function to burn tokens
    function burnTokens(uint256 amount) public {
        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount);
    }

    // Function to get the number of owned art pieces of a specific type
    function getOwnedArtPiecesAmount(ArtPieces pieceType) public view returns (uint256) {
        return ownedArtPieces[msg.sender][pieceType];
    }

    // Function to get the price of a specific art piece type
    function valueArtPiece(ArtPieces pieceType) external view returns (uint256) {
        return piecePrices[pieceType];
    }

    // Function for the owner to withdraw funds from the contract
    function withdrawArtistFunds(uint256 amount) external onlyOwner {
        require(balanceOf(address(this)) >= amount, "Insufficient contract balance");
        _transfer(address(this), msg.sender, amount);
    }
}
