const Web3 = require('web3');
const Hex2XToken = artifacts.require('Hex2XToken');

const {ether, toHex, toWei} = require('./utils/ethTools');
const {assertRevert} = require('./utils/assertRevert');

const BigNumber = web3.BigNumber;
require('chai')
  .use(require('chai-bignumber')(BigNumber))
  .should();

let hex2xToken;
let accounts = [];
const _tokenName = "Hex2X";
const _tokenSymbol = "H2X";
const _tokenDecimals = 18;
const ZERO_ADDRESS = '0x0000000000000000000000000000000000000000';

contract('Hex2XToken', function([
  owner,
  tokenHolder1,
  tokenHolder2,
  tokenHolder3
]) {
  accounts = [
    owner,
    tokenHolder1,
    tokenHolder2,
    tokenHolder3
  ];

  before(async function() {
    hex2xToken = await Hex2XToken.deployed();
    const Web3 = require('web3');
  });
  describe('Check if initial token parameters were set', function() {
    it('1.1 Token Name', async function() {
      assert.equal(await hex2xToken.name(), _tokenName);
    });
    it('1.2 Token Symbol', async function() {
      assert.equal(await hex2xToken.symbol(), _tokenSymbol);
    });
    it('1.2 Token Decimals', async function() {
      assert.equal(await hex2xToken.decimals(), _tokenDecimals);
    });
  });
  describe('Mint Tokens', function() {
    it('2.1 Mint tokens to owner', async function() {
      await hex2xToken.mint(owner, (1e18).toString());
      assert.equal((await hex2xToken.balanceOf(owner))*1, (1e18).toString());
      assert.equal((await hex2xToken.totalSupply())*1, (1e18).toString());
    });
     it('2.2 Mint tokens to tokenHolder1', async function() {
      await hex2xToken.mint(tokenHolder1, (1e18).toString());
      assert.equal((await hex2xToken.balanceOf(tokenHolder1))*1, (1e18).toString());
    });
  });
  describe('Transfer Tokens', function() {
    it('3.1 Transfer tokens from owner to tokenHolder2', async function() {
      await assertRevert(hex2xToken.transfer(tokenHolder2, (2e18).toString()));
      await hex2xToken.transfer(tokenHolder2, (2e17).toString());
      await assertRevert(hex2xToken.transfer(ZERO_ADDRESS, (2e17).toString()));
      assert.equal((await hex2xToken.balanceOf(tokenHolder2))*1, (2e17).toString());
    });
    it('3.2 Provide token transfer allowance to owner', async function() {
      await hex2xToken.increaseAllowance(owner, (1e18).toString(), {from:tokenHolder1});
      await hex2xToken.increaseAllowance(owner, (1e17).toString(), {from:tokenHolder2});
      await assertRevert(hex2xToken.increaseAllowance(ZERO_ADDRESS, (1e17).toString(), {from:tokenHolder1}));
      assert.equal((await hex2xToken.allowance(tokenHolder1, owner))*1, (1e18).toString());
    });
    it('3.3 Transfer tokens of tokenHolder1 to tokenHolder3 by owner', async function() {
      await hex2xToken.transferFrom(tokenHolder1, tokenHolder3, (1e17).toString(), {from:owner});
      assert.equal((await hex2xToken.balanceOf(tokenHolder3))*1, (1e17).toString());
      await assertRevert(hex2xToken.transferFrom(tokenHolder1, tokenHolder3, (1e18).toString(), {from:owner}));
    });
    it('3.2 Provide token transfer allowance to owner', async function() {
      await hex2xToken.decreaseAllowance(owner, (1e17).toString(), {from:tokenHolder2});
      await assertRevert(hex2xToken.decreaseAllowance(owner, (1e17).toString(), {from:tokenHolder2}));
      assert.equal((await hex2xToken.allowance(tokenHolder2, owner))*1, 0);
    });
  });
  describe('Burn Tokens', function() {
    it('4.1 Burn tokenHolder1 tokens', async function() {
      let tokenHolder1Balance = (await hex2xToken.balanceOf(tokenHolder1))*1;
      await assertRevert(hex2xToken.burnFrom(tokenHolder1, tokenHolder1Balance.toString(), {from:tokenHolder2}));
      await hex2xToken.burnFrom(tokenHolder1, tokenHolder1Balance.toString());
      assert.equal((await hex2xToken.balanceOf(tokenHolder1))*1, 0);
    });
    //  it('4.2 Mint tokens to tokenHolder1', async function() {
    //   await hex2xToken.mint(tokenHolder1, (1e18).toString());
    //   assert.equal((await hex2xToken.balanceOf(tokenHolder1))*1, (1e18).toString());
    // });
  });
})
