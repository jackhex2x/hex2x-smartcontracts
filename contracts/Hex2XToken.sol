pragma solidity 0.5.7;

import "./external/openzeppelin-solidity/token/ERC20/ERC20Detailed.sol";
import "./external/openzeppelin-solidity/ownership/Ownable.sol";

contract Hex2XToken is ERC20Detailed, Ownable {

    constructor() public ERC20Detailed("Hex2X","H2X",18) {
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
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    /*
    * @dev Mint 'amount' tokens to 'account' address
    */
    function mint(address account, uint256 amount) public onlyOwner returns (bool) {
        _mint(account, amount);
        return true;
    }
}