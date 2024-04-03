##### Development environment:- <br />
OS: Mac OS 14.0 <br />
Editor: XCode v15.1 <br />
Swift 5.9 <br />

##### _PROBLEMS TO SOLVE_

Kiki has invested in N no. of vehicles and have driver partners to drive each vehicle & deliver packages.

## Problem 01
Delivery Cost Estimation with Offers
Since it’s a new business, the team has decided to pass coupons around the town which will help them attract more customers.


## Problem 02
Delivery Time Estimation
Now all these packages should be delivered to their destinations in the fleet of vehicles Kiki owns. She has N no. of vehicles available for delivering the packages.

## _HOW TO RUN?_

1. Through XCode
Open the directory in XCode, make sure selected schema should be eec and selected run destination should be mac, and Run it using `command (⌘) + R`. For test cases use `command (⌘) + U`

2. Though terminal
- Go to the directory on terminal and use `swift test` to run test cases.
- Use 4 different options to run different function
```
    swift run EEC --get-all-offer-codes
    swift run EEC --add-new-offer-code
    swift run EEC --calculate-delivery-cost
    swift run EEC --calulate-delivery-time
```
