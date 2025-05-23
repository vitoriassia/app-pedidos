## Project Overview

A simple Flutter application that consumes a RESTful API using OAuth 2.0 authentication. Users can:
- View a list of orders (GET /orders)
- Create new orders (POST /orders)
- Finalize orders (PUT /orders/{orderId}/finish)

## Requirements

- OAuth 2.0 authentication (password and refresh_token grants)
- Secure storage and management of access and refresh tokens
- GET, POST, and PUT API calls with authenticated requests
- Simple, intuitive UI using MVVM pattern with Provider
- Dependency injection for services and repositories

## Technical Details

- **Flutter & Dart**  
- **State management:** Provider with ChangeNotifier  
- **Architecture pattern:** MVVM  
- **Dependency injection:** get_it  
- **Network client:** Dio with custom `ApiService` and `AuthInterceptor`  
- **Secure storage:** flutter_secure_storage via abstraction  

## Setup and Running

1. **Clone the repository**  
   ```bash
   git clone <repository-url>
   cd pedidos_app
   ```

2. **Install dependencies**  
   ```bash
   flutter pub get
   ```

3. **Configure OAuth credentials**  
   - You can set a default user in the `GetTokenPayload.password` factory, or simply enter your email and password on the login screen.  

4. **Run the application**  
   ```bash
   flutter run
   ```

## API Endpoints

- **Token**: `POST /connect/token` (x-www-form-urlencoded)  
- **Fetch orders**: `GET /orders`  
- **Create order**: `POST /orders`  
- **Finalize order**: `PUT /orders/{orderId}/finish`