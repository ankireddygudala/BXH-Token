pragma solidity ^0.4.17;
contract Owener{
    address public admin;
    function Owener() public{
        admin = msg.sender;
    }
    modifier onlyOwener(){
        require(msg.sender == admin);
        _;
    }
    function transferAdminship(address newAdmin) public onlyOwener{
        admin = newAdmin;
    }
}
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
contract AssertToken is Owener, Token{
    
    function AssertToken(uint256 initialSupply, string tokenName, string tokenSymbol, uint8 decimalUinis, address centralAdmin) Token(0,tokenName, tokenSymbol, decimalUinis)public{
        totalSupply = initialSupply;
        if(centralAdmin != 0){
            admin = centralAdmin;
        }
        else{
            admin = msg.sender;
        }
        balances[admin] = initialSupply;
        totalSupply = initialSupply;
    }
    
    function mintToken(address target, uint256 mintedAmount) public {
        balances[target] += mintedAmount;
        totalSupply += mintedAmount;
        Transfer(0,this,mintedAmount);
        Transfer(this,target, mintedAmount);
    }
    function transfer(address _to, uint256 _value) public{
        require(balances[msg.sender] > 0);
        require(balances[msg.sender] > _value);
        
        require(balances[_to] + _value > balances[_to]);
        
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        
    }
}