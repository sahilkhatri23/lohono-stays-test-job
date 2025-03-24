# Villa Booking API

This API allows users to find available villas and check their prices efficiently. It ensures that villas are only shown when available and calculates prices including GST.

## Setup Instructions

### Clone the Repository
```sh
git clone https://github.com/sahilkhatri23/lohono-stays-test-job.git
cd lohono-stays-test-job
```

### Install Dependencies
Ensure Ruby and Bundler are installed, then run:
```sh
bundle install
```

### Setup the Database
This application uses PostgreSQL. Ensure it is installed and running, then run:
```sh
rails db:create
rails db:migrate
```

### Start the Rails Server
```sh
rails s
```
The API will be available at `http://localhost:3000`.

## API Endpoints

### Get Available Villas
Fetch villas that are available between selected dates and sort them by price.
```sh
GET /villas?check_in=YYYY-MM-DD&check_out=YYYY-MM-DD&sort_by_price=asc|desc
```

#### Example Request
```sh
GET /villas?check_in=2025-01-10&check_out=2025-01-15&sort_by_price=asc
```

#### Example Response
```json
{
  "villas": [
    { "id": 1, "name": "Ocean View", "average_price_per_night": 32000 },
    { "id": 2, "name": "Palm Villa", "average_price_per_night": 35000 }
  ]
}
```

### Calculate Total Price and Availability
Check if a specific villa is available for the requested dates and calculate the total price including GST.
```sh
GET /villas/:id/calculate_price?check_in=YYYY-MM-DD&check_out=YYYY-MM-DD
```

#### Example Request
```sh
GET /villas/1/calculate_price?check_in=2025-01-10&check_out=2025-01-15
```

#### Example Response (Available)
```json
{
  "available": true,
  "total_price": 177000
}
```

#### Example Response (Not Available)
```json
{
  "available": false,
  "message": "Villa is not available for the full requested period"
}
```

## How It Works Internally

### Checking Availability
- The API checks if the villa is available for the full requested period.
- If any date is unavailable, the villa is not included in the response.

### Sorting by Price
- Villas can be sorted in ascending or descending order based on the average price per night.

### Date Management
- The API ensures that only fully available periods are considered for booking.

## Future Improvements
- Implement pagination for large villa lists.
- Add user authentication for booking villas.
- Develop an admin panel to manage villas and bookings.
- Optimize database queries for better performance.
