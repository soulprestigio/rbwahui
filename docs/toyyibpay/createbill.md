# ToyyibPay API Documentation

This document outlines the various endpoints available in the ToyyibPay API.

## Bills

### Create Bill

A Bill serves as an invoice to your customer. The following parameters are required to create a new bill.

**Endpoint:** `https://dev.toyyibpay.com/index.php/api/createBill`

#### Parameters

*   `userSecretKey` (string, required): Your user secret key.
*   `categoryCode` (string, required): Get your Category Code from the "Create Category" API.
*   `billName` (string, required): The name of the bill, which will be displayed as the bill title. Max 30 alphanumeric characters, space, and `_` only.
*   `billDescription` (string, required): A description for the bill. Max 100 alphanumeric characters, space, and `_` only.
*   `billPriceSetting` (integer, required): 
    *   `1`: For a fixed amount bill.
    *   `0`: For a dynamic bill where the user can insert the amount to pay.
*   `billPayorInfo` (integer, required):
    *   `0`: Create an open bill without requiring payer information.
    *   `1`: Require payer information.
*   `billAmount` (integer, required): The bill amount in cents (e.g., `100` = RM1.00). If `billPriceSetting` is `0` (dynamic bill), this must be `0`.
*   `billReturnUrl` (string, optional): The URL to redirect the user to upon payment completion.
*   `billCallbackUrl` (string, optional): The URL to send a callback to upon a successful payment transaction.
*   `billExternalReferenceNo` (string, optional): Your own system's reference number. You can use this to check the payment status.
*   `billTo` (string, optional): The name of the person the bill is for. Leave blank if not applicable.
*   `billEmail` (string, optional): The customer's email address.
*   `billPhone` (string, optional): The customer's phone number.
*   `billSplitPayment` (integer, optional): Set to `1` if the payment needs to be split among other toyyibPay users. Not available for dynamic bills. *Note: Split Payment is available for Online Banking (FPX) only.*
*   `billSplitPaymentArgs` (JSON string, optional): Provide a JSON object for the split payment details. Example: `'''[{"id":"johndoe","amount":"200"}]'''`
*   `billPaymentChannel` (integer, optional):
    *   `0`: FPX
    *   `1`: Credit Card
    *   `2`: Both FPX & Credit Card
*   `billContentEmail` (string, optional): An additional message to send to the customer via email. Limited to 1000 characters.
*   `billChargeToCustomer` (integer, optional):
    *   Leave blank: Bill owner bears charges for both FPX and Credit Card.
    *   `0`: Charge FPX fee to the customer. *Note: Not available for card payments.*
*   `billChargeToPrepaid` (boolean, optional): Deducts the transaction charge from the prepaid account. Applicable only for FPX when charges are set to the bill owner.
*   `billExpiryDate` (string, optional): The date and time to set the bill as inactive (e.g., `"17-12-2020 17:00:00"`). Payer cannot pay after this date.
*   `billExpiryDays` (integer, optional): Number of days (1-100) to allow payment attempts. The bill expires at 23:59:59 on the final day. `billExpiryDate` takes precedence if both are set.
*   `enableFPXB2B` (integer, optional): Set to `1` to enable FPX (Corporate Banking) payment channel.
*   `chargeFPXB2B` (integer, optional): Charge for FPX (Corporate Banking). Default is `1`.
    *   `0`: Charge to customer.
    *   `1`: Charge to bill owner.

#### Sample Request (PHP)

```php
<?php
  $some_data = array(
    'userSecretKey'=>'w5x7srq7-rx5r-3t89-2ou2-k7361x2jewhn',
    'categoryCode'=>'gcbhict9',
    'billName'=>'Car Rental WXX123',
    'billDescription'=>'Car Rental WXX123 On Sunday',
    'billPriceSetting'=>0,
    'billPayorInfo'=>1,
    'billAmount'=>100,
    'billReturnUrl'=>'http://bizapp.my',
    'billCallbackUrl'=>'http://bizapp.my/paystatus',
    'billExternalReferenceNo' => 'AFR341DFI',
    'billTo'=>'John Doe',
    'billEmail'=>'jd@gmail.com',
    'billPhone'=>'0194342411',
    'billSplitPayment'=>0,
    'billSplitPaymentArgs'=>'',
    'billPaymentChannel'=>'0',
    'billContentEmail'=>'Thank you for purchasing our product!',
    'billChargeToCustomer'=>1,
    'billExpiryDate'=>'17-12-2020 17:00:00',
    'billExpiryDays'=>3
  );  

  $curl = curl_init();
  curl_setopt($curl, CURLOPT_POST, 1);
  curl_setopt($curl, CURLOPT_URL, 'https://dev.toyyibpay.com/index.php/api/createBill');  
  curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($curl, CURLOPT_POSTFIELDS, $some_data);

  $result = curl_exec($curl);
  $info = curl_getinfo($curl);  
  curl_close($curl);
  $obj = json_decode($result);
  echo $result;
?>
```

#### Sample Response

The API returns a `BillCode` in JSON format. The payment URL will be `https://dev.toyyibpay.com/{BillCode}`.

```json
[
  {
    "BillCode": "gcbhict9"
  }
]
```

---

### Get Bill Transactions

Check the payment status of a bill by providing its `billCode`.

**Endpoint:** `https://dev.toyyibpay.com/index.php/api/getBillTransactions`

#### Parameters

*   `billCode` (string, required): The code of the bill to check.
*   `billpaymentStatus` (integer, optional): Filter transactions by status:
    *   `1`: Successful
    *   `2`: Pending
    *   `3`: Unsuccessful
    *   `4`: Pending

#### Sample Request (PHP)

```php
<?php
  $some_data = array(
    'billCode' => 'td8bfqv7',
    'billpaymentStatus' => '1'
  );

  $curl = curl_init();
  curl_setopt($curl, CURLOPT_POST, 1);
  curl_setopt($curl, CURLOPT_URL, 'https://dev.toyyibpay.com/index.php/api/getBillTransactions');  
  curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($curl, CURLOPT_POSTFIELDS, $some_data);

  $result = curl_exec($curl);
  $info = curl_getinfo($curl);  
  curl_close($curl);

  echo $result;
?>
```

#### Sample Response

```json
[
    {
        "billName": "Payment_for_order_51",
        "billDescription": "Payment_for_order_51",
        "billTo": "Ali Bin Abu",
        "billEmail": "alibinabu@gmail.com",
        "billPhone": "0123456789",
        "billStatus": "1",
        "billpaymentStatus": "1",
        "billpaymentChannel": "FPX",
        "billpaymentAmount": "10.00",
        "billpaymentInvoiceNo": "TP5793119399122400030321",
        "billSplitPayment": "1",
        "billSplitPaymentArgs": "[{"id":"toyyibPaySupport","amount":"100"}]",
        "billpaymentSettlement": "Settlement Done",
        "billpaymentSettlementDate": "2021-03-03 17:15:33",
        "SettlementReferenceNo": "TP030321956",
        "billPaymentDate": "02-03-2021 16:24:25",
        "billExternalReferenceNo": "WP0001"
    }
]
```

---

### Inactive Bill

Use this API to set a bill to "inactive".

**Endpoint:** `https://dev.toyyibpay.com/index.php/api/inactiveBill`

#### Parameters

*   `secretKey` (string, required): Your toyyibPay account Secret Key.
*   `billCode` (string, required): The `BillCode` of the bill to deactivate.

#### Sample Request (PHP)

```php
<?php
  $some_data = array(
    'secretKey' => 'w5x7srq7-rx5r-3t89-2ou2-k7361x2jewhn',
    'billCode' => 'a7usb2'
  );

  $curl = curl_init();
  curl_setopt($curl, CURLOPT_POST, 1);
  curl_setopt($curl, CURLOPT_URL, 'https://dev.toyyibpay.com/index.php/api/inactiveBill'); 
  curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($curl, CURLOPT_POSTFIELDS, $some_data);

  $result = curl_exec($curl);
  $info = curl_getinfo($curl);  
  curl_close($curl);

  $obj = json_decode($result);
  echo $result;
?>
```

#### Sample Responses

*   **Success:**
    ```json
    {"status":"success","result":"Bill status changed to inactive"}
    ```
*   **Failure (Pending Transaction):**
    ```json
    {"status":"failed","result":"Bill has pending transaction process"}
    ```
*   **Failure (Already Inactive):**
    ```json
    {"status":"failed","result":"Bill is inactive"}
    ```

---

## Callbacks & Redirects

### Callback URL

The Callback URL will receive a `POST` request with the following data. *Note: This cannot be a `localhost` URL.*

*   `refno`: Payment reference number.
*   `status`: Payment status (`1`=success, `2`=pending, `3`=fail).
*   `reason`: Reason for the status.
*   `billcode`: Your bill code.
*   `order_id`: Your external reference number.
*   `amount`: Payment amount received.
*   `transaction_time`: Datetime of the transaction.

### Return URL

The Return URL will receive a `GET` request with the following query parameters:

*   `status_id`: Payment status (`1`=success, `2`=pending, `3`=fail).
*   `billcode`: Your bill code.
*   `order_id`: Your external reference number.

---

## Categories

### Get Category Details

Retrieve information for a specific category.

**Endpoint:** `https://dev.toyyibpay.com/index.php/api/getCategoryDetails`

#### Parameters

*   `userSecretKey` (string, required): Your user secret key.
*   `categoryCode` (string, required): The code for the category.

#### Sample Request (PHP)

```php
<?php
  $some_data = array(
    'userSecretKey' => 'w5x7srq7-rx5r-3t89-2ou2-k7361x2jewhn',
    'categoryCode' => 'Ajdiufd345f'
  );  

  $curl = curl_init();
  curl_setopt($curl, CURLOPT_POST, 1);
  curl_setopt($curl, CURLOPT_URL, 'https://dev.toyyibpay.com/index.php/api/getCategoryDetails'); 
  curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($curl, CURLOPT_POSTFIELDS, $some_data);

  $result = curl_exec($curl);
  $info = curl_getinfo($curl);  
  curl_close($curl);

  $obj = json_decode($result);
  echo $result;
?>
```

#### Sample Response

```json
[
    {
        "categoryName": "Makanan",
        "categoryDescription": "Kuih Cara",
        "categoryStatus": "1"
    }
]
```

---

## Enterprise Partner APIs

These APIs are for Enterprise accounts only.

### Create User

Create a new toyyibPay user via the API. Returns a `UserSecretKey` for use in other API calls.

**Endpoint:** `https://dev.toyyibpay.com/index.php/api/createAccount`

#### Parameters

*   `enterpriseUserSecretKey` (string, required): Your enterprise user secret key.
*   `Fullname` (string, required): User's full name.
*   `User name` (string, required): Username for login. Max 30 alphanumeric characters, no spaces or special characters.
*   `Email` (string, required): User's email or a unique user ID.
*   `Password` (string, required): User's password.
*   `Phone` (string, required): User's phone number.
*   `Bank Account Type` (integer, optional): Default is `2`.
    *   `1`: Personal Saving Account
    *   `2`: Business / Company Current Account
    *   `3`: Society / Organisation Current Account
*   `Bank` (integer, required): The user's bank selection (see Get Bank API).
*   `Account No` (string, required): User's bank account number.
*   `Account Holder Name` (string, required): Name of the account holder.
*   `Registration No` (string, optional): Company/Business/Organization registration number.
*   `Package` (integer, required): The user package.
*   `userStatus` (integer, optional): Set to `2` to make the account active immediately without email confirmation.

#### Sample Request (PHP)

```php
<?php
  $some_data = array(
    'enterpriseUserSecretKey' => 'abcdef-ghijk-lmnop-qrstu',
    'fullname' => 'John Doe Sdn Bhd',
    'username' => 'johndoe',
    'email' => 'hi@johndoe.com',
    'password' => '123456',
    'phone' => '0134342400',
    'bankAccountType' => '1',
    'bank'=>1,
    'accountNo'=>'162263282063',
    'accountHolderName'=>'John Doe',
    'registrationNo'=>'BBYUUI',
    'package' => 1
  );

  $curl = curl_init();
  curl_setopt($curl, CURLOPT_POST, 1);
  curl_setopt($curl, CURLOPT_URL, 'https://dev.toyyibpay.com/index.php/api/createAccount');  
  curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($curl, CURLOPT_POSTFIELDS, $some_data);

  $result = curl_exec($curl);
  $info = curl_getinfo($curl);  
  curl_close($curl);
  $obj = json_decode($result);
  echo $result;
?>
```

#### Sample Response

```json
[
  {
  	"UserSecretKey" : "vrbl86xf-wj1h-q0l3-95kk-4q4erulvsc0h"
  }
]
```

---


### Get Bank List

Get a list of banks accepted by toyyibPay.

**Endpoint:** `https://dev.toyyibpay.com/index.php/api/getBank`

#### Sample Request (PHP)

```php
<?php
  $curl = curl_init();
  curl_setopt($curl, CURLOPT_POST, 0);
  curl_setopt($curl, CURLOPT_URL, 'https://dev.toyyibpay.com/index.php/api/getBank');  
  curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);

  $result = curl_exec($curl);
  $info = curl_getinfo($curl);  
  curl_close($curl);

  echo $result;
?>
```

#### Sample Response

```json
[
    {"id":"2","bank":"CIMB Bank","status":"1"},
    {"id":"3","bank":"Bank Islam","status":"1"},
    {"id":"4","bank":"Public Bank","status":"1"},
    {"id":"5","bank":"Hong Leong Bank","status":"1"},
    {"id":"6","bank":"RHB Bank","status":"1"},
    {"id":"7","bank":"Ambank","status":"1"},
    {"id":"8","bank":"Bank Rakyat","status":"1"},
    {"id":"9","bank":"Alliance Bank","status":"1"},
    {"id":"10","bank":"Affin Bank","status":"1"},
    {"id":"11","bank":"Bank Muamalat","status":"1"},
    {"id":"12","bank":"Bank Simpanan Nasional","status":"1"},
    {"id":"13","bank":"Standard Chartered","status":"1"},
    {"id":"14","bank":"OCBC Bank","status":"1"},
    {"id":"15","bank":"Agro Bank","status":"1"},
    {"id":"16","bank":"UOB Bank","status":"1"},
    {"id":"17","bank":"HSBC","status":"1"},
    {"id":"18","bank":"Kuwait Finance House","status":"1"},
    {"id":"21","bank":"Al Rajhi Bank","status":"1"},
    {"id":"22","bank":"Citibank Berhad","status":"1"},
    {"id":"23","bank":"Maybank","status":"1"},
    {"id":"24","bank":"MBSB Bank","status":"1"}
]
```

---

### Get User Status

Check a user's account status.

**Endpoint:** `https://dev.toyyibpay.com/index.php/api/getUserStatus`

#### Parameters

*   `username` (string, required): The username to check.
*   `enterpriseUserSecretKey` (string, required): Your enterprise user secret key.

#### Status Codes
*   `0`: Inactive
*   `1`: New-Pending Approval
*   `2`: Active

#### Sample Request (PHP)

```php
<?php
  $some_data = array(
    'username' => 'johndoe',
    'enterpriseUserSecretKey' => 'h9ijfq4y-hrha-jsmj-s4br-r5hll1g29ty'
  );  

  $curl = curl_init();
  curl_setopt($curl, CURLOPT_POST, 1);
  curl_setopt($curl, CURLOPT_URL, 'https://dev.toyyibpay.com/index.php/api/getUserStatus');  
  curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($curl, CURLOPT_POSTFIELDS, $some_data);

  $result = curl_exec($curl);
  $info = curl_getinfo($curl);  
  curl_close($curl);
  echo $result;
?>
```

#### Sample Response

```json
[
  {
    "status": "1"
  }
]
```

---


### Get Settlement Summary

Get a summary of all settlements.

**Endpoint:** `https://dev.toyyibpay.com/api/getSettlementSummary`

#### Parameters

*   `userSecretKey` (string, required): Secret key for the Enterprise User.
*   `userName` (string, required): The username to get the summary for.

#### Sample Request (PHP)

```php
<?php
$some_data = array(
  'userSecretKey' => 'td8bfqv7',
  'userName' => "Sample Username"
);

$curl = curl_init();
curl_setopt($curl, CURLOPT_POST, 1);
curl_setopt($curl, CURLOPT_URL, 'https://dev.toyyibpay.com/api/getSettlementSummary');  
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_POSTFIELDS, $some_data);

$result = curl_exec($curl);
$info = curl_getinfo($curl);  
curl_close($curl);

echo $result;
?>
```

#### Sample Response

```json
[
	{
		"userID": "44",
		"userName": "fitweb",
		"today": "19-10-31",
		"Amount_Pending": "1.00",
		"Amount_settle": "5.00",
		"AmountNett_Pending": "1.00",
		"AmountNett_Settle": "0.00",
		"Different_Pending": "0.00",
		"Different_Settle": "5.00",
		"Standard_Pending": "0.00",
		"Standard_Settle": "0.00",
		"Santai_Pending": "1.00",
		"Santai_Settle": "5.00",
		"Creditcard_Pending": "0.00",
		"Creditcard_settle": "0.00",
		"Transaction_Pending": "6",
		"Trnsaction_Settle": "6"
	}
]
```