# 🏡 Villa Booking API

This API helps users find available villas and check their prices efficiently.  
It ensures that villas are only shown when available and calculates prices including GST.

---

## ⚡️ Setup Instructions

Follow these steps to set up and run the project:

### 1️⃣ **Clone the Repository**
```sh
git clone https://github.com/sahilkhatri23/lohono-stays-test-job.git
cd lohono-stays-test-job
```

### 2️⃣ **Install Dependencies**
Ensure you have **Ruby** and **Bundler** installed, then run:
```sh
bundle install
```

### 3️⃣ **Setup the Database**
This app uses **PostgreSQL**, so ensure it's installed and running.  
Then, create and migrate the database:
```sh
rails db:create
rails db:migrate
```

### 4️⃣ **Seed Fake Data (Generate Villas & Bookings)**
To populate the database with **50 villas and 100 random bookings**, run:
```sh
rails db:seed
```

### 5️⃣ **Start the Rails Server**
Run the following command to start the API server:
```sh
rails s
```
Your API will be available at:  
📍 **http://localhost:3000**

---

## 📌 **API Endpoints**
### 1️⃣ **Get Available Villas**
**Fetch villas that are available between selected dates and sort them by price (ascending or descending).**
```sh
GET /villas?check_in=YYYY-MM-DD&check_out=YYYY-MM-DD&sort_by=price&sort_order=asc|desc
```
#### **🔹 How It Works**
- The API **checks if the villa is available** for all requested nights.
- If available, the villa is **included in the response**.
- You can **sort results** by `price` (ascending or descending).

#### **📌 Example Request**
```sh
GET /villas?check_in=2025-01-10&check_out=2025-01-15&sort_by=price&sort_order=asc
```
#### **✅ Example Response**
```json
{
  "villas": [
    { "id": 1, "name": "Ocean View", "price_per_night": 32000 },
    { "id": 2, "name": "Palm Villa", "price_per_night": 35000 }
  ]
}
```

---

### 2️⃣ **Calculate Total Price & Availability**
**Check if a specific villa is available for the requested dates and calculate the total price including GST.**
```sh
GET /villas/:id/calculate_price?check_in=YYYY-MM-DD&check_out=YYYY-MM-DD
```
#### **🔹 How It Works**
- **Step 1:** The API checks if the villa has any **overlapping bookings**.
- **Step 2:** If available, the **total price is calculated** as:
  \[
  (\text{Number of Nights} × \text{Price Per Night}) + 18\% GST
  \]

#### **📌 Example Request**
```sh
GET /villas/1/calculate_price?check_in=2025-01-10&check_out=2025-01-15
```
#### **✅ Example Response (Available)**
```json
{
  "available": true,
  "total_price": 177000
}
```
#### **❌ Example Response (Not Available)**
```json
{
  "available": false,
  "message": "Villa is not available for the selected dates."
}
```

---

## 🛠 **How It Works Internally**
1️⃣ **Checking Availability**  
- The API looks at all **existing bookings** for a villa.  
- If a villa is already booked for the requested dates, it **won't be available**.  

2️⃣ **Sorting by Price**  
- The API allows sorting by **price in ascending or descending order**.  
- Uses **ActiveRecord scopes** for efficient database queries.  

3️⃣ **Date Management**  
- The system **automatically sets** check-in time to **11:00 AM** and check-out time to **10:00 AM**.  

---

## 🚀 **Future Improvements**
- ✅ Add **pagination** to handle large villa lists efficiently.
- ✅ Implement **user authentication** to allow villa booking.
- ✅ Add **admin panel** to manage villas and bookings.
- ✅ To speed up repeated requests, availability checks are **cached for 10 minutes**.

---

## 🏆 **Conclusion**
This API efficiently **manages villa availability and pricing**, making it easy to find and book villas dynamically. 🚀  