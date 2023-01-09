# SLIIT Eats

An application for canteen management and food ordering built by the FOSS Community at Sri Lanka Institute of Information Technology.

### Features
#### For canteens
- Set up and manage profiles for canteen staff members to login with.
- Manage operations of multiple canteens via single platform.
- Add or edit product details, product categories and stocks in food items in a canteen.
- View orders received for a specific canteen, and update their statuses as ready for pick up or have the order timeout if not picked up within a a certain time period.

#### For users
- Register as a user to browse products and place orders at canteens.
- Search for products and filter search results by canteen and/or product category.
- Create new orders and view the progress of each order, including time left for a reserved order to expire.
- Receive notifications when an order is ready to be picked up from a canteen.

## Screenshots

### User views

<img src="https://user-images.githubusercontent.com/62464945/211340700-5f455087-5725-4187-8094-e8f345e7e3af.jpeg" width="200" />    <img src="https://user-images.githubusercontent.com/62464945/211340748-9b003286-d28f-4121-b5bb-65798d607432.jpeg" width="200" />    <img src="https://user-images.githubusercontent.com/62464945/211340772-76a3ea41-a20b-410a-8b5e-d6d95084aa4e.jpeg" width="200" />    <img src="https://user-images.githubusercontent.com/62464945/211340801-f271fe40-7b99-42a9-90eb-a494d994aa64.jpeg" width="200" />    <img src="https://user-images.githubusercontent.com/62464945/211341065-5eff88f6-5351-4374-af5f-219fcc318b73.jpeg" width="200" />

### Canteen staff views

<img src="https://user-images.githubusercontent.com/62464945/211341906-81025577-67e6-4524-88f0-d14362546193.jpeg" width="200" />    <img src="https://user-images.githubusercontent.com/62464945/211341911-2b1a11b3-c2ff-4791-b372-cb858d210bc6.jpeg" width="200" />
<img src="https://user-images.githubusercontent.com/62464945/211341919-2f8d4712-5b31-4b35-a3ee-b0b13c3a6397.jpeg" width="200" />    <img src="https://user-images.githubusercontent.com/62464945/211341925-65f0024c-8f94-43da-b41f-aa3c0b1656cc.jpeg" width="200" />    <img src="https://user-images.githubusercontent.com/62464945/211341927-a42b18eb-77ea-4bda-afd3-d772dc62b073.jpeg" width="200" />        <img src="https://user-images.githubusercontent.com/62464945/211341935-8f36b57f-2596-4750-a51d-7fcdfd028344.jpeg" width="200" />

## Technologies Used

- Flutter
- Firebase

## Getting Started

- Run flutter pub get to install dependancies
- Run flutter build apk --debug for debug build

Note - Release build requires a signed key (Follow the comments in the app level build.gradle to bypass this)

### Pre-requirements

- A Firebase account
- Flutter SDK version >= 2.12.0

### Build and release

- Run flutter build apk --release for release build

### The .env file

This project requires a .env file structured in the following way:

```
SLIIT_EATS_FIREBASE_API_KEY=<<KEY>>
SLIIT_EATS_FIREBASE_APP_ID=<<VALUE>>
SLIIT_EATS_FIREBASE_PROJECT_ID=<<VALUE>>
SLIIT_EATS_FIREBASE_BUCKET=<<VALUE>>
SLIIT_EATS_FCM_SENDER_ID=<<VALUE>>

SLIIT_EATS_SERVER_URL=<<VALUE>>
```

### The push notification server

SLIIT Eats depends upon a small Express server which orchestrates the transmission of Firebase Cloud Messaging (FCM) notifications (specified in the `SLIIT_EATS_SERVER_URL` value of the .env file.). <br />
This was intended as a quick solution and the ideal approach would be to setup something of a cloud function for the purpose.
