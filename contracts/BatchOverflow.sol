pragma solidity 0.4.10;

contract BatchOverflow {
    uint256 private decimal = 10**18;
    uint256 private totalSupply = 10**27;
    mapping(address => uint256) internal balances;

    function mint() public payable {
        // 1 wei = 1 BatchOverFlow token
        balances[msg.sender] = balances[msg.sender] + msg.value * (10**18);
    }

    function batchTransfer(address[] recipients_, uint256 value_)
        public
        constant
        returns (bool)
    {
        // Numbers Of Recipients
        uint256 nor = recipients_.length;
        uint256 _amount = nor * value_;

        require(balanceOf(msg.sender) >= _amount, "Insufficient amount");
        require(value_ > 0);
        require(nor > 0 && nor <= 20);

        balances[msg.sender] = balances[msg.sender] - _amount;

        for (uint256 i = 0; i < nor; i++) {
            balances[recipients_[i]] = balances[recipients_[i]] + value_;
        }
    }

    function balanceOf(address address_) public constant returns (uint256) {
        return balances[address_];
    }
}
