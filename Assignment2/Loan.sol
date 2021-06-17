// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <0.7.0;

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

library SafeMath {

    function add (uint256 a, uint256 b) internal pure returns(uint256) {
        uint256 c = a+b;
        assert(c>=a);
        return c;
    }

    function fullMul (uint256 a, uint256 b) internal pure returns(uint256 h, uint256 l){
        uint256 mm = mulmod(a, b, uint256(-1));
        l = a*b;
        h = (mm-l);
        if(mm<l)    
		h -= 1;
        return (h, l);
    }

    function mulDiv (uint256 x, uint256 y, uint256 z) internal pure returns(uint256) {
        (uint256 h, uint256 l) = fullMul(x, y);
        require (h < z);  
        uint mm = mulmod (x, y, z);
        if (mm > l) h -= 1;
        l -= mm;  
        uint pow2 = z & -z;
        z /= pow2;
        l /= pow2;
        l += h * ((-pow2) / pow2 + 1);  uint r = 1;
        r *= 2 - z * r;
        r *= 2 - z * r;
        r *= 2 - z * r;
        r *= 2 - z * r;
        r *= 2 - z * r;
        r *= 2 - z * r;
        r *= 2 - z * r;
        r *= 2 - z * r;  
        return l * r;
    }

}



contract MetaCoin{
	mapping (address => uint256) balances;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	constructor() public {
		balances[tx.origin] = 100000;
	}

	function sendCoin(address receiver, uint256 amount, address sender) public returns(bool sufficient) {
		if (balances[sender] < amount) return false;
		balances[sender] -= amount;
		balances[receiver] += amount;
		emit Transfer(sender, receiver, amount);
		return true;
	}


	function getBalance(address addr) public view returns(uint256) {
		return balances[addr];
	}
}

// Try not to edit the contract definition above


contract Loan is MetaCoin {
    mapping (address => uint256) private loans;
     
    event Request(address indexed _from, uint256 P, uint R, uint T, uint256 amt);
    
    address private Owner;
    
    modifier isOwner() {
       require(msg.sender == Owner);
       _;
    }
    
    constructor() public{
        Owner = msg.sender;
    }
    
    
    function getCompoundInterest(uint256 principle, uint rate, uint time) public pure returns(uint256) {
    		
    	uint256 R = rate; uint256 T = time; uint256 P = principle;
    		
        for (uint i=1; i<=T;i++) {
           P = SafeMath.add(P, SafeMath.mulDiv(P,R,1000000000000000000));
        }
        return P;
    }
    
    function reqLoan(uint256 principle, uint rate, uint time) public returns(bool correct) {
        
        uint256 toPay = getCompoundInterest(principle, rate, time);
        uint256 check = loans[msg.sender];
        
	loans[msg.sender] += toPay;
        
        if(loans[msg.sender < check]){
        return false;}
        
        emit Request(msg.sender,principle,rate,time,toPay);
        return true;
        
    }
    function getOwnerBalance() public view returns(uint256) {
	return getBalance(Owner);
	}
    
    function viewDues(address creditor) public isOwner view returns(uint256){
        return loans[creditor];
    	}
    
    function settleDues(address creditor) public isOwner returns (bool){
        bool check = sendCoin(creditor,loans[creditor],Owner);
        if(check){
            loans[creditor] = 0;
        }
        
        return check;
        
    }
}
