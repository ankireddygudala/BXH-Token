pragma solidity ^0.4.17;

contract Token{
    mapping (address => uint) public balances;
    string public name;
    string public symbol;
    uint8 public decimal;
    uint256 public totalSupply;

    event Transfer(address from, address to, uint256 value);

    //Token initilization 
    function Token(uint256 initialSupply, string tokenName, string tokenSymbol, uint8 decimalUinis) public {
        totalSupply = initialSupply;
        balances[msg.sender] = initialSupply;
        name = tokenName;
        symbol = tokenSymbol;
        decimal = decimalUinis;
    }  
    
    //transfer function 
    function transfer(address _to, uint256 _value) public{
        require(balances[msg.sender] > _value);
        require(balances[_to] + _value > balances[_to]);

        balances[_to] += _value;
        balances[msg.sender] -= _value;
        Transfer(msg.sender, _to, _value);
    }
}