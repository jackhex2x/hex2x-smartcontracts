pragma solidity 0.5.7;

import "./external/openzeppelin-solidity/token/ERC20/ERC20.sol";
import "./external/openzeppelin-solidity/ownership/Ownable.sol";

contract Hex2XToken is ERC20, Ownable {

    string public constant name = "Hex2X";
    string public constant symbol = "Hex2X";
    uint8 public constant decimals = 8;

    constructor() public {
    }

    /*
    * @dev transfer 'amount' tokens to 'recipient' address
    */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    /*
    * @dev Burn 'amount' tokens from caller address reducing totalSupply
    */
    function burnFrom(address account, uint256 amount) public onlyOwner {
        _burnFrom(account, amount);
    }

    /*
    * @dev Mint 'amount' tokens to 'account' address
    */
    function mint(address account, uint256 amount) public onlyOwner returns (bool) {
        _mint(account, amount);
        return true;
    }
}