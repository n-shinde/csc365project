# API Specification - Peak Peeps

## 1. User Social Network

### 1.1. Add Friend - `/socials/{friend}/add` (POST)

Makes a request to add another user as a friend. 

**Request**:

```json
{
  "username": "string",
}
```

**Returns**:

```json
{
    "success": "boolean"
}
```

### 1.2. Accept Friend Request - `/socials/{friend}/` (PUT)

Accepts or deletes a given friend request based on user's decision.
If accepted, both users can view each other's profiles. 

**Request**:

```json
{
  "username": "string",
  "request_status": "boolean"
}
```

**Returns**:

```json
{
    "success": "boolean"  
}
```

### 1.3. Friend Request Status - `/socials/{friend}/` (GET)

Returns a message to the user notifying them if a friend request was accepted or denied.

```json
{
    "request_status": "string"
}
```

## 2. Routes

### 2.1. Add Route - `/routes/add` (POST)

Adds a route to the list of routes available to view on the app.

**Request**:

```json
[
  {
    "name": "string",
    "date_added": "string",
    "user_added": "string",
    "location": "string",
    "coordinates": [lat, long],
    "length_in_miles": "double",
    "difficulty": "string",
    "activities": "string",
  }
]
```

**Returns**:

```json
[
    {
      "success": "boolean"
    }
]
```

### 2.2. Report Route - `/routes/report` (POST)

Reports a route by flagging it as inappropriate, returns a status confirming the report has been made.

**Request**:

```json
[
  {
    "route_name": "string",
    "date_added": "string",
    "date_reported": "string",
    "report_author": "string",
    "coordinates": [lat, long],
    "description": "string",
  }
]
```

**Returns**:

```json
[
    {
      "report_status": "string",
      "flagged": "boolean"
    }
]
```

### 2.3. View Popular Routes - `/routes/popular` (GET)

Returns a list of popular routes posted on the app.

```json
[
    {
      [     /* List of routes with the following attributes displayed:

        "name": "string",
        "date_added": "string",
        "user_added": "string",
        "location": "string",
        "coordinates": [lat, long],
        "length_in_miles": "double",
        "difficulty": "string",
        "activities": "string",
        "popularity_index": int,
        "five_star_reviews": int

      ]
    }
]
```

### 2.4. View Friends Routes - `/routes/friends` (GET)

Returns a list of routes a user's friend has visited on the app.

**Request**:

```json
[
  {
    "friend_username": "string"   /* The username of the friend being searched up 
  }
]
```

**Returns**:

```json
[
    {
      [     /* List of routes with the following attributes displayed:

        "name": "string",
        "date_added": "string",
        "user_added": "string",
        "location": "string",
        "coordinates": [lat, long],
        "length_in_miles": "double",
        "difficulty": "string",
        "activities": "string",

      ]
    }
]
```

## 3. Reviews

### 3.1. Write New Review - `/reviews/new` (POST)

Creates a new review and posts it on the route page.

**Request**:

```json
[
  {
    "author_name": "string"  
    "rating": ["1 star", "2 star", "3 star", "4 star", "5 star"]   /* List of rating options
    "description: "string"
  }
]
```

**Returns**:

```json
[
    {
      "success": boolean
    }
]
```

## 4. Customer Purchasing

### 4.1. Add PeepCoins - `/peepcoins/add` (PUT)

Adds PeepCoins to user's account balance.

**Request**:

```json
{
  "coins_to_add": "integer"
}
```

**Returns**:

```json
{
    "success": "boolean"
}
```

### 4.2. Buy Coupon with PeepCoins - `/peepcoins/purchase/coupon` (POST)

Executes coupon transaction using available PeepCoins.

**Request**:

```json
{
  "coupon_name": "string",
  "coupon_price": "int",
  "valid": "boolean",
}
```

**Returns**:

```json
{
    "success": "boolean",
    "transaction_details": "string"
}
```
