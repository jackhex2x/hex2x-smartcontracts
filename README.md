
<h1><a id="Hex2X Token"></a>Hex2X Token</h1>
<p>Smart contracts for Hex2x - A lucratively high-interest currency, designed to reward stakers. https://hex2x.org/.</p>
<h4><a id="Contracts"></a>	Contracts</h4>
<ul>
<li>Hex2XToken.sol - ERC-20 compilant token</li>
</ul>

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 


### Requirements
```
Node >= 10.x
```


### Installing
Firstly, you need to clone this repo. You can do so by downloading the repo as a zip and unpacking or using the following git command

```
git clone https://github.com/somish/hex2x-smartcontracts.git
```

Now, It's time to install the dependencies. Enter the hex2x-smartcontracts directory and use

```
npm install
```
Make sure you delete folder `bitcore-lib` from node_modules inside modules `eth-lightwallet` and `bitcore-mnemonic`

We need to compile the contracts before deploying.
```
npm run compile
```
Now, You should start a private network on port 8545 using Ganache or something similar. To run the private network - </br>
On Windows, Execute file startGanache.bat present in hex2x-smartcontracts/scripts directory </br>
On Linux or Mac OS Systems, run the startGanache.sh file while in hex2x-smartcontracts/scripts directory
```
./startGanache.sh
```
  
Then, you can deploy your Hex2X Token using the migrate script. 
```
npm run deploy
```
If you want, you can run the test cases using
```
npm run test
```
And run generate the coverage report using
```
npm run coverage
```