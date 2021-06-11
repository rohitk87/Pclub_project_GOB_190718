<h1>Loan Implementation in MetaCoin</h1>
MetaCoin implements a basic token which the accounts can give to each other with the ``sendCoin`` function, and see their balance with the ``getBalance`` function. Here, we have made a smart contract extending the functionality of the MetaCoin to provide functionality of acting as a loan deposit and settling contract.

<h2>Running the code</h2>
  1. Upload the Loan.sol file to Remix IDE and compile it.
  2. Next deploy the Loan contract for the owner.
  3. Check the functionality of the functions to see if they work or not.

<h2>SafeMath implementation</h2>
SafeMath library has been included in the code to work around limitations of solidity in dealing with floating point calculations and prevent Overflow of operators.
Functions such as ``add(x,y)`` (Returns x+y, In case of overflow gives an error.)  ``fullMul(x,y)`` (Returns ``x*y`` as a 256 bit each (h,l) pair of integers and 
``mulDiv(x,y,z)`` which returns ``x*y/z`` have been implemented.

<h2>Implementation of various members of Loan Contract</h2>
Following are the said member functions:
  1. ``modifier isOwner()``: Checks wether ``msg.sender`` is the ``Owner`` of the contract.
  2. ``function getCompoundInterest(uint256 principle, uint rate, uint time)``: calculates and returns compound interest for the given parameters. It is a pure function as it  doesn't change the state variables.
  3. ``function reqLoan(uint256 principle, uint rate, uint time)``: Calculates and requests back the due amount of loan which the ``owner`` has yet to pay to ``msg.sender``. Value of this address is incremented in ``loan`` map.
  4. ``function getOwnerBalance()``: returns the balance of owner of the Loan Contract.
  5. ``function viewDues(address creditor)``: Returns the dues of ``creditor``, Only owner of Loan contract can call this function.
  6. ``function settleDues(address creditor)``: ``owner`` settles the dues with ``creditor``, uses ``sendCoin`` function of the parent class. Only owner of the Loan contract can call this function.
