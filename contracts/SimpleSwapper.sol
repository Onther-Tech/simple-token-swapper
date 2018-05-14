pragma solidity ^0.4.23;


import "openzeppelin-solidity/contracts/ownership/CanReclaimToken.sol";
import "openzeppelin-solidity/contracts/ownership/HasNoEther.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

/// @notice SimpleSwapper swap 2 different tokens with same amount.
///  SimpleSwapper should have enough token amount of sourceToken
///  to serve swap service.
contract SimpleSwapper is CanReclaimToken, HasNoEther {
  /// @notice swap sourceToken from Swapper and targetToken from msg.sender.
  function swap(ERC20 sourceToken, ERC20 targetToken) public returns(bool) {
    require(address(sourceToken) != address(targetToken));

    uint256 approve = targetToken.allowance(msg.sender, this);
    uint256 balance = sourceToken.balanceOf(address(this));

    require(balance >= approve);

    require(targetToken.transferFrom(msg.sender, this, approve));
    require(sourceToken.transfer(msg.sender, approve));

    return true;
  }
}
