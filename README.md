# HOTEL MANAGEMENT APPLICATION
By Mili Bimal Parikh AND Mahta Maymandi Nejad

## Overview

This is a simple application in Java that uses JDBC connector to
connect to MySQL using a username and password provided by the
user. The `JDBC` jar file is in the `\lib` folder.

Marriott Hotel and Resorts is a company that offers lodging in hotels
in various cities across the country. 
In this project we created a console-based application in Java that can
handle hotel reservations for this chain of hotels. 
This application connects with the database and allows the user to create a new
reservation for any hotels in the chain, update a reservation or cancel a reservation.
The application also allows the user to see the hotel amenities at any hotel from the chain
and also see the hotel manager's contact information.

Further, the application lets the admin user see the information regarding the hotel managers
of all the hotels including their personal information like salary and date of hire etc.
This information can be accessed by the admin only upon entering the correct credentials - username
password.

## Database
The database contains 10 tables. These tables include information on the ho-
tels, hotel amenities, room types, staff, managers, guests, bookings, booking
cancellations, and customer reviews.

Tables are:
1. amenities
2. bookings
3. guests
4. hotel_amenities
5. hotel_managers
6. hotel_rooms
7. marriott_hotel_chain
8. reviews
9. room_types
10. staff

The Java application will call the stored procedures and handle user inter-
action.
The database has the following stored procedures:
1. `allHotels()` -> To get the list of all hotels in this chain of Mariott Hotels
2. `roomTypes()` -> To get the list of all room types in all the hotels
3. `createBooking()` -> To create a new reservation, it adds new rows to `bookings` and `guests` table.
It takes all guest details and booking details as input.
4. `modifyBooking()` -> To modify any existing booking in the `bookings` table. This procedure takes
`bookingId`, updated `check_in_date` and updated `check_out_date` as input parameters and finds the
row from the `bookings` table by the bookingId and updates the row.
5. `cancelBooking()` -> To cancel a reservation using the bookingId. It takes the `bookingId` 
from the user as input and deletes that particular row from the `bookings` table.
6. `findHotelManagersContactInfo()` -> To display the contact information of any hotel's manager.
It takes the `hotelId` as input and displays the information of hotel manager like name,
phone number ad email Id.
7. `findHotelAmenities()` -> To display the amenities of any particular hotel. It takes the 
`hotelId` as input and displays a list of all the hotel amenities available.
8. `findHotelManagers()` -> To display the information of all the hotel managers to the `admin` user.

The database also has the following stored function:
1. `getBookingId()` -> This function returns the `bookingId` of the reservation upon creation.
2. `max_guestId()` -> This function returns the maximum value of `gid` from the `guests` table.
It is used to make a new entry in the database.

## User Interaction

The Java application lets the user do the following actions:
1. `New Reservation` -> Using this action, the user is prompted to enter a few details and
make a new booking. Calling this action calls the method `newReservation()` and this method
calls the `createBooking()` procedure. It adds new rows to `bookings` and `guests` table.
After the row is added, it displays the `bookingID` to the user to confirm the reservation.

2. `Modify Reservation` -> Using this action, the user can update an existing booking in the
database. The user is prompted to enter the `bookingId` along with the updated `check_in_date` 
and updated `check_out_date`. Calling this action calls the method `updateReservation()` and this method
calls the `modifyBooking()` procedure.

3. `Cancel Reservation` -> Using this action, the user can cancel an existing booking in the
database. The user is prompted to enter the `bookingID`. Calling this action calls the method 
`cancelReservation()` and this method calls the `cancelBooking()` procedure.

4. `Show Hotel Amenities` -> Using this action, the user can see the amenities at a particular hotel
from the chain by entering the hotelId. Calling this action calls the method
`displayHotelAmenities()` and this method calls the `findHotelAmenities()` procedure.

5. `Get Hotel manager's contact information` -> Using this action, the user can see the contact
information - name, phone and email Id of the hotel manager of a particular hotel from the chain
using the hotelId. Calling this action calls the method `displayHotelManagerContactInfo()` and this 
method calls the `findHotelManagersContactInfo()` procedure.

6. `Display Hotel Manager's Information (Admin)` -> This action is only for the admin user. 
To access this, the user needs to enter the admin username and password and only if the
credentials are correct, the user is shown the information of all the hotel managers of all hotels
in this chain. Calling this action calls the method `displayHotelManagersInfoAdmin()` and this
   method calls the `findHotelManagers()` procedure.


## Steps to use the program

Run the program (via the main method in `Reservations` class) using command :

```
javac Reservations.java
java Reservations
```

or you can also use the .jar file in the /res folder and use the command:

```
java -jar reservations.java
```

To run this program, you will need a JDBC connector .jar file. For ease of using the program,
I am adding the .jar file in the /res folder.
You need to add that to the modules using the following steps:
1. In IntelliJ, go to the File -> Project Structure -> Modules
2. Under the "dependencies" tab, click on "+" and choose the location of the JDBC jar file
3. Next, click on "Apply" button

This should work and the application will be connected to the database.

In the Reservations.java code, change two lines ->
private static final String username = "root";
private static final String password = "@Shaili02";

Here, enter the username and password of your MySQL workbench where you load the database.

Next, run the application using the commands shown above.

On running, you will first be prompted with the welcome message and the actions that you
can do to interact with the application.
Follow the instructions as prompted. You can also see a sample run attached below.

## Sample Run and Sample Inputs

Start the program and welcome message:

```
"C:\Users\Mili Parikh\.jdks\corretto-17.0.4.1\bin\java.exe" "-javaagent:C:\Program Files\JetBrains\IntelliJ IDEA Community Edition 2021.3.3\lib\idea_rt.jar=55703:C:\Program Files\JetBrains\IntelliJ IDEA Community Edition 2021.3.3\bin" -Dfile.encoding=UTF-8 -classpath "C:\Users\Mili Parikh\NEU_SEM1\DBMS\HotelReservation\out\production\HotelReservation;C:\Users\Mili Parikh\NEU_SEM1\DBMS\mysql-connector-j-8.0.31\mysql-connector-j-8.0.31\mysql-connector-j-8.0.31.jar" Reservations
Database connection is established with user : root
Welcome to hotel reservations app! 
You can choose any of the following actions.
To choose an action, enter the number beside it.
1 --> New Reservation
2 --> Update Reservation
3 --> Cancel Reservation
4 --> Show Hotel amenities
5 --> Get Hotel manager's contact information
6 --> Display Hotel Manager's Information (Admin)
Q --> Quit
```

Sample to make a new Reservation:

```
1
To make a new reservation, add the details as prompted below: 
Enter your first name: 
Amy
Enter your last name: 
Hale
Enter your date of birth: 
1999-09-12
Enter your gender (Male or Female): 
Female
Enter your country of residence: 
USA
Enter your street address: 
3Byner
Enter your city: 
Truro
Enter your state: 
MA
Enter your postal code: 
02381
Enter phone number: 
97234873874
Enter email ID: 
amy@sms.com
List of cities where we have our hotels: 
here
[Boston, Worcester , Natick, Lowell, New York]
1: Boston
2: Worcester 
3: Natick
4: Lowell
5: New York
Enter the number beside the city you wish to stay in: 
2
Enter the number of guests staying: 
2
List of all room types in the selected hotel: 
1: Deluxe Garden View
2: Partial Harbor View
3: Traditional Deluxe
4: Premium View
5: Executive Parlor
6: Bedroom Suite
7: Single Suite
Enter the room type (String): 
Deluxe
Enter the check in date in the format YYYY-MM-DD: 
2022-12-09
Enter the check out date in the format YYYY-MM-DD: 
2022-12-31
Reservation confirmed!
Entry made in the database.
Booking Done!
Booking ID is : 11
```

Sample to update a reservation: 
```
2
To modify a booking, please enter the following details: 
Enter the booking ID: 
11
Enter the new check-in date (YYYY-MM-DD): 
2022-12-11
Enter the new check-out date (YYYY-MM-DD): 
2022-12-20
Updated Reservation!
```

Sample to cancel a reservations:
```
3
Enter the following information to cancel a reservation. 
Enter the booking ID: 
11
Are you sure you want to cancel?
Enter Y or N : 
Y
Reservation cancelled!
```

Sample to see the hotel amenities:
```
4
To see the amenities of a particular hotel, enter the number beside the city where you wish to stay: 
here
[Boston, Worcester , Natick, Lowell, New York]
1: Boston
2: Worcester 
3: Natick
4: Lowell
5: New York
Enter the number: 
2
Amenities at this hotel are: 
1: parking
2: wifi
4
To see the amenities of a particular hotel, enter the number beside the city where you wish to stay: 
here
[Boston, Worcester , Natick, Lowell, New York]
1: Boston
2: Worcester 
3: Natick
4: Lowell
5: New York
Enter the number: 
1
Amenities at this hotel are: 
1: parking
2: restaurant
3: bar
4: wifi
5: pool

```

Sample to see the hotel manager's contact information:
```
5
To get the hotel manager's contact information, enter the number beside the desired hotel's city: 
here
[Boston, Worcester , Natick, Lowell, New York]
1: Boston
2: Worcester 
3: Natick
4: Lowell
5: New York
Enter the number: 
1
Name: Joshua Hall
Phone Number: 9282744491
Email: joshua_mh@gmail.com

5
To get the hotel manager's contact information, enter the number beside the desired hotel's city: 
here
[Boston, Worcester , Natick, Lowell, New York]
1: Boston
2: Worcester 
3: Natick
4: Lowell
5: New York
Enter the number: 
2
Name: James Carter
Phone Number: 8678559275
Email: james_mh@gmail.com

```

Sample to see all the hotel's manager's information:
```
6
To get the information of all hotel manager's you need toenter the "admin" username and password. 
Enter the admin username: 
admin
Enter the admin password: 
admin@admin
Correct credentials.
Here's the required information: 
unique_id     first_name      last_name   date_of_hireemployment_type         salary           role            hid hotel_location
    3         Joshua           Hall2021-01-15 12:00:00      Full-time       80200.00        Manager              1         Boston
    5          James         Carter2021-04-19 12:00:00      Part-time       72000.00        Manager              2     Worcester 
    7          David         Walker2021-10-15 12:00:00      Full-time       75000.00        Manager              3         Natick
    8           Mary       Hepzibah2021-10-15 12:00:00      Part-time       82000.00        Manager              4         Lowell
    6         Joseph          Scott2020-09-19 12:00:00      Full-time       56000.00        Manager              5       New York
```

## Lessons Learned
1. Technical expertise gained -> From this project, we gained a good grip over creating a java
application that connects to MySQL using the JDBC API and extract the data from the database
to use in our application. We learnt how to user stored procedures and functions from SQL to 
get the required data in Java application. 
We also learnt how to create a good database as per the requirements of the application.
2. Insights and alternative design / approaches -> It was initially difficult to coordinate on work. But then we decided that one of
us will work on the database whereas the other one would work on the Java application and it 
worked out well for us. We initially planned to use python but later dropped the idea as we 
were more comfortable with Java and found a similar example online so it was easier for us to follow.
3. The code fails to work in certain cases when the user enters wrong information than what is asked
from the user. The error handling can be improved.

## Future Scope
We aim to build more in this application and use other tables from the database as well
to make reservations for amenities at hotels. We can also add more functions for the admin user type.
We also aim to build a GUI using Java GUI so that it's easier for the user to interact.

## Citations
1. https://www.w3schools.com/sql/sql_delete.asp
2. https://www.youtube.com/watch?v=-yiL99KFeng
3. https://www.youtube.com/watch?v=zGnL-LIFT9Y
4. https://www.mysqltutorial.org/calling-mysql-stored-procedures-from-jdbc/
5. https://stackoverflow.com/questions/16990976/call-stored-mysql-function
6. https://www.tutorialspoint.com/how-to-call-an-existing-function-in-a-database-using-jdbc-api
7. https://stackoverflow.com/questions/47593233/getting-error-cant-set-in-parameter-for-return-value-of-stored-function-call
8. https://www.baeldung.com/java-string-to-date
9. https://docs.oracle.com/javase/tutorial/java/data/numberformat.html



