<h1>Loan Implementation in MetaCoin</h1>
MetaCoin implements a basic token which the accounts can give to each other with the <code>sendCoin</code> function, and see their balance with the <code>getBalance</code> function. Here, we have made a smart contract extending the functionality of the MetaCoin to provide functionality of acting as a loan deposit and settling contract.

<h2>Running the code</h2><ol>
<li> Upload the Loan.sol file to Remix IDE and compile it.</li>
<li> Next deploy the Loan contract for the owner.</li>
<li> Check the functionality of the functions to see if they work or not.</li></ol>

<h2>SafeMath implementation</h2>
SafeMath library has been included in the code to work around limitations of solidity in dealing with floating point calculations and prevent Overflow of operators.
Functions such as <code>add(x,y)</code> (Returns x+y, In case of overflow gives an error.)  <code>fullMul(x,y)</code> (Returns <code>x*y</code> as a 256 bit each (h,l) pair of integers and 
<code>mulDiv(x,y,z)</code> which returns <code>x*y/z</code> have been implemented.

<h2>Implementation of various members of Loan Contract</h2><ol>
Following are the said member functions:
  
  <li> <code>modifier isOwner()</code>: Checks wether <code>msg.sender</code> is the <code>Owner</code> of the contract.</li><br>
  
  <li> <code>function getCompoundInterest(uint256 principle, uint rate, uint time)</code>: calculates and returns compound interest for the given parameters. It is a pure function as it  doesn't change the state variables.</li><br>
  
  <li> <code>function reqLoan(uint256 principle, uint rate, uint time)</code>: Calculates and requests back the due amount of loan which the <code>owner</code> has yet to pay to <code>msg.sender</code>. Value of this address is incremented in <code>loan</code> map.</li><br>
  
  <li> <code>function getOwnerBalance()</code>: returns the balance of owner of the Loan Contract.</li><br>
  
  <li> <code>function viewDues(address creditor)</code>: Returns the dues of <code>creditor</code>, Only owner of Loan contract can call this function.</li><br>
  
  <li> <code>function settleDues(address creditor)</code>: <code>owner</code> settles the dues with <code>creditor</code>, uses <code>sendCoin</code> function of the parent class. Only owner of the Loan contract can call this function.</li><br>
</ol>
