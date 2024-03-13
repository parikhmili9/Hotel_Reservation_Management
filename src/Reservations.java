import java.math.BigDecimal;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Scanner;

public class Reservations {

  private static Connection connection;
  private static Statement statement;
  private static final String username = "root";
  private static final String password = "@Shaili02";
  private static final String adminUsername = "admin";
  private static final String adminPassword = "admin@admin";

  //Lists
  private static List<String> allHotelsList;
  private static List<String> allRoomTypesList;

  //New Reservation
  private static int guestId;
  private static int hotelId;
  private static int numberOfGuests;
  private static String roomType;
  private static LocalDate currentDate;
  private static LocalDate check_in;
  private static LocalDate check_out;


  private static void connectToDatabase() throws SQLException {
    try{
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb",
          Reservations.username, Reservations.password);
      System.out.println("Database connection is established with user : " + Reservations.username);
    } catch (SQLException se){
      System.out.println("1");
      System.out.println("ERROR: Could not connect to the database");
      System.out.println(se.getMessage());
    }
  }

  private static int getNumberOfGuestIds() {
    int maxGuestId = 0;
    try {
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb",
          username, password);
      statement = connection.createStatement();
      ResultSet resultSet = statement.executeQuery("SELECT max_guestId() as guestId;");

      CallableStatement cstmt = connection .prepareCall("{? = call max_guestId()}");
      cstmt.registerOutParameter(1, Types.INTEGER);
      cstmt.execute();
      maxGuestId = cstmt.getInt(1);
//      maxGuestId = Integer.parseInt(resultSet.getString("guestId"));
//      System.out.println(maxGuestId);
    } catch (SQLException sql) {
      System.out.println("2");
      System.out.println("ERROR: Could not connect to the database");
      System.out.println(sql.getMessage());
      sql.printStackTrace();
    }
    return maxGuestId;
  }

  private static List<String> getAllHotels() {
    try {
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb",
          username, password);
      statement = connection.createStatement();
      ResultSet resultSet = statement.executeQuery("CALL allHotels();");
      allHotelsList = new ArrayList<>();
      while (resultSet.next()) {
        allHotelsList.add(resultSet.getString("city"));
      }
      System.out.println("here");
      System.out.println(allHotelsList);
    } catch (SQLException sql) {
      System.out.println("3");
      System.out.println("ERROR: Could not connect to the database");
      System.out.println(sql.getMessage());
    }
    return allHotelsList;
  }

  private static List<String> getAllRoomTypes() {
    try {
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb",
          username, password);
      statement = connection.createStatement();
      ResultSet resultSet = statement.executeQuery("CALL roomTypes();");
      allRoomTypesList = new ArrayList<>();
      while (resultSet.next()) {
        if(!allRoomTypesList.contains(resultSet.getString("room_type"))) {
          allRoomTypesList.add(resultSet.getString("room_type"));
        }
      }
    } catch (SQLException sql) {
      System.out.println("4");
      System.out.println("ERROR: Could not connect to the database");
      System.out.println(sql.getMessage());
    }
    return allRoomTypesList;
  }

  private static void newReservation(String gfirstName, String glastName, String gDob,
      String ggender, String gcountry, String gstreet, String gcity, String gstate,
      String gpcode, String gphone, String gemail, int hotelId, int numberOfGuests,
                                     String roomType, String checkInDate, String checkOutDate) {

//    newReservation(firstName, lastName, dateOfBirth, gender, country, streetAddress,
//        city, state, postalCode, phone, email, hotelId, number_of_guests, roomType,
//        checkInDate, checkOutDate);

    guestId = getNumberOfGuestIds() + 1;
    currentDate = java.time.LocalDate.now();

    try {
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb",
          username, password);
      statement = connection.createStatement();
      CallableStatement cstmt = connection
          .prepareCall("{call createBooking(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
      cstmt.setString(1, gfirstName);
      cstmt.setString(2, glastName);
      cstmt.setDate(3, Date.valueOf(gDob));
      cstmt.setString(4, ggender);
      cstmt.setString(5, gcountry);
      cstmt.setString(6, gstreet);
      cstmt.setString(7, gcity);
      cstmt.setString(8, gstate);
      cstmt.setString(9, gpcode);
      cstmt.setString(10, gphone);
      cstmt.setString(11, gemail);
      cstmt.setInt(12, hotelId);
      cstmt.setInt(13, numberOfGuests);
      cstmt.setString(14, roomType);
      cstmt.setDate(15, Date.valueOf(currentDate));
      cstmt.setDate(16, Date.valueOf(checkInDate));
      cstmt.setDate(17, Date.valueOf(checkOutDate));
      cstmt.execute();
      System.out.println("Reservation confirmed!");
    } catch (SQLException sql) {
      System.out.println("new reservation");
      System.out.println("ERROR: Could not connect to the database");
      System.out.println(sql.getMessage());
      sql.printStackTrace();
    }

    System.out.println("Entry made in the database.");
  }

  private static int displayBookingId(int guestId, int hotelId, String roomType) {
    int bookingId = 0;
    try {
//      String query = "SELECT getBookingId("+ guestId + "," + hotelId + ","
//      + "\"" + roomType + "\"" + ");" ;
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb",
          username, password);
      statement = connection.createStatement();
//      ResultSet resultSet = statement.executeQuery(query);

      CallableStatement cstmt = connection .prepareCall("{? = call getBookingId(?)}");
//      System.out.println("GuestId : " + guestId);
      cstmt.setInt(2, guestId);
      cstmt.registerOutParameter(1, Types.INTEGER);
      cstmt.execute();
      bookingId = cstmt.getInt(1);
//      System.out.println("here: " + bookingId);
    } catch (SQLException sql) {
      System.out.println("5");
      System.out.println("ERROR: Could not connect to the database");
      System.out.println(sql.getMessage());
      sql.printStackTrace();
    }
    return bookingId;
  }

  private static void updateReservation(int bookingId, String checkInDate, String checkOutDate) {
    try{
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb",
          username, password);
      statement = connection.createStatement();
      CallableStatement cstmt = connection .prepareCall("{call modifyBooking(?,?,?)}");
      cstmt.setInt(1, bookingId);
      cstmt.setDate(2, Date.valueOf(checkInDate));
      cstmt.setDate(3, Date.valueOf(checkOutDate));
      cstmt.execute();
      System.out.println("Updated Reservation!");
    } catch (SQLException sql) {
      System.out.println("6");
      System.out.println("ERROR: Could not connect to the database");
      System.out.println(sql.getMessage());
      sql.printStackTrace();
    }

  }

  private static void cancelReservation(int bookingId) {
    try {
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb",
          username, password);
      statement = connection.createStatement();
      CallableStatement cstmt = connection .prepareCall("{call cancelBooking(?)}");
      cstmt.setInt(1, bookingId);
      cstmt.execute();
      System.out.println("Reservation cancelled!");
    } catch (SQLException sql) {
      System.out.println("7");
      System.out.println("ERROR: Could not connect to the database");
      System.out.println(sql.getMessage());
      sql.printStackTrace();
    }
  }

  private static List<String> displayHotelAmenities(int hotelId) {
    List<String> hotelAmenitiesList = new ArrayList<>();
    try {
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb",
          username, password);
      statement = connection.createStatement();
      ResultSet resultSet = statement
          .executeQuery(String.format("CALL findHotelAmenities(%d)", hotelId));
      while (resultSet.next()) {
        hotelAmenitiesList.add(resultSet.getString("amenity"));
      }
//      CallableStatement cstmt = connection.prepareCall(" ? = {call findHotelAmenities(?)}");
//      cstmt.setInt(1, hotelId);
//      cstmt.execute();

    } catch (SQLException sql) {
      System.out.println("8");
      System.out.println("ERROR: Could not connect to the database");
      System.out.println(sql.getMessage());
      sql.printStackTrace();
    }
    return hotelAmenitiesList;
  }

  public static StringBuilder displayHotelManagerContactInfo(int hotelId) {
    StringBuilder info = new StringBuilder();
    try {
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb",
          username, password);
      statement = connection.createStatement();
      ResultSet resultSet = statement
          .executeQuery(String.format("CALL findHotelManagersContactInfo(%d)", hotelId));
      while (resultSet.next()) {
        info.append("Name: ");
        info.append(resultSet.getString("manager_first_name"));
        info.append(" ");
        info.append(resultSet.getString("manager_last_name")).append("\n");
        info.append("Phone Number: ");
        info.append(resultSet.getString("phone")).append("\n");
        info.append("Email: ");
        info.append(resultSet.getString("email")).append("\n");
      }
    } catch (SQLException sql) {
      System.out.println("7");
      System.out.println("ERROR: Could not connect to the database");
      System.out.println(sql.getMessage());
      sql.printStackTrace();
    }
    return info;
  }

  private static void displayHotelManagersInfoAdmin() {
    String salary;
    String unique_id, hid;
    String first_name, last_name, date_of_hire, employment_type, role,
        hotel_location, state;

    try{
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb",
          username, password );
      statement = connection.createStatement();

      ResultSet resultSet = statement.executeQuery("CALL findHotelManagers()");
      Object[][] table = new String[6][9];

      table[0] = new String[] {"unique_id", "first_name", "last_name", "date_of_hire",
          "employment_type", "salary", "role", "hid", "hotel_location"};
      int i = 1;
      while (resultSet.next()){
        unique_id = String.valueOf(resultSet.getInt("unique_id"));
        first_name = resultSet.getString("manager_first_name");
        last_name = resultSet.getString("manager_last_name");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        date_of_hire = dateFormat.format(resultSet.getDate("date_of_hire"));
        employment_type = resultSet.getString("employment_type");
        salary = resultSet.getBigDecimal("salary").toString();
        role = resultSet.getString("role");
        hid = String.valueOf(resultSet.getInt("hid"));
        hotel_location = resultSet.getString("hotel_location");

        table[i] = new String[] {unique_id, first_name, last_name, date_of_hire, employment_type,
        salary, role, hid, hotel_location};
        i++;
      }

      for (Object[] row : table) {
        if(row[0] != null){
          System.out.format("%5s%15s%15s%15s%15s%15s%15s%15s%15s%n", row);
        }
      }

    } catch (SQLException sql){
      System.out.println("8");
      System.out.println("ERROR: Could not connect to the database");
      System.out.println(sql.getMessage());
      sql.printStackTrace();
    }
  }

  public static void main(String[] args) throws SQLException {

    connectToDatabase();
    System.out.println("Welcome to hotel reservations app! ");
    System.out.println("You can choose any of the following actions.");
    System.out.println("To choose an action, enter the number beside it.");
    System.out.println("1 --> New Reservation");
    System.out.println("2 --> Update Reservation");
    System.out.println("3 --> Cancel Reservation");
    System.out.println("4 --> Show Hotel amenities");
    System.out.println("5 --> Get Hotel manager's contact information");
    System.out.println("6 --> Display Hotel Manager's Information (Admin)");
//    System.out.println("7 --> Display Hotel Staff's Information");
    System.out.println("Q --> Quit");

    Scanner scanner = new Scanner(System.in);

    while (true) {
      String input = scanner.next();
      switch (input) {
        case "1" -> {
          System.out.println("To make a new reservation, add the details as prompted below: ");

          //Guest Details
          System.out.println("Enter your first name: ");
          String firstName = scanner.next();
          System.out.println("Enter your last name: ");
          String lastName = scanner.next();
          System.out.println("Enter your date of birth: ");
          String dateOfBirth = scanner.next();
          System.out.println("Enter your gender (Male or Female): ");
          String gender = scanner.next();
          System.out.println("Enter your country of residence: ");
          String country = scanner.next();
          System.out.println("Enter your street address: ");
          String streetAddress = scanner.next();
          System.out.println("Enter your city: ");
          String city = scanner.next();
          System.out.println("Enter your state: ");
          String state = scanner.next();
          System.out.println("Enter your postal code: ");
          String postalCode = scanner.next();
          System.out.println("Enter phone number: ");
          String phone = scanner.next();
          System.out.println("Enter email ID: ");
          String email = scanner.next();


          //List of all cities with hotels
          System.out.println("List of cities where we have our hotels: ");
          List<String> allCitiesHotels = getAllHotels();
          int counter = 0;
          for (String s : allCitiesHotels) {
            counter = counter + 1;
            System.out.println(counter + ": " + s);
          }

          //Hotel Id
          System.out.println("Enter the number beside the city you wish to stay in: ");
          int hotelId = scanner.nextInt();

          //Number Of guests
          System.out.println("Enter the number of guests staying: ");
          int number_of_guests = scanner.nextInt();

          //All Room Types List
          System.out.println("List of all room types in the selected hotel: ");
          List<String> allRoomTypes = getAllRoomTypes();
          int counter1 = 0;
          for (String s : allRoomTypes) {
            counter1 = counter1 + 1;
            System.out.println(counter1 + ": " + s);
          }

          //Room Type
          System.out.println("Enter the room type (String): ");
          String roomType = scanner.next();

          System.out.println("Enter the check in date in the format YYYY-MM-DD: ");
          String checkInDate = scanner.next();

          System.out.println("Enter the check out date in the format YYYY-MM-DD: ");
          String checkOutDate = scanner.next();

          newReservation(firstName, lastName, dateOfBirth, gender, country, streetAddress,
              city, state, postalCode, phone, email, hotelId, number_of_guests, roomType,
              checkInDate, checkOutDate);
          System.out.println("Booking Done!");
          System.out.println("Booking ID is : " + displayBookingId(guestId, hotelId, roomType));
        }
        case "2" -> {
          System.out.println("To modify a booking, please enter the following details: ");
          System.out.println("Enter the booking ID: ");
          int bookingId = scanner.nextInt();
          System.out.println("Enter the new check-in date (YYYY-MM-DD): ");
          String checkIn = scanner.next();
          System.out.println("Enter the new check-out date (YYYY-MM-DD): ");
          String checkOut = scanner.next();
          updateReservation(bookingId, checkIn, checkOut);
        }
        case "3" -> {
          System.out.println("Enter the following information to cancel a reservation. ");
          System.out.println("Enter the booking ID: ");
          int cancel_bookingId = scanner.nextInt();
          System.out.println("Are you sure you want to cancel?");
          System.out.println("Enter Y or N : ");
          String in = scanner.next();
          if (in.equals("Y")) {
            cancelReservation(cancel_bookingId);
          } else {
            System.out.println("Booking is not cancelled. ");
            break;
          }
        }

        case "4" -> {
          System.out.println("To see the amenities of a particular hotel, " +
              "enter the number beside the city where you wish to stay: ");
          List<String> allCitiesHotels = getAllHotels();
          int counter = 0;
          for (String s : allCitiesHotels) {
            counter = counter + 1;
            System.out.println(counter + ": " + s);
          }
          System.out.println("Enter the number: ");
          int hotelIdForAmenities = scanner.nextInt();
          List<String> amenitiesList = displayHotelAmenities(hotelIdForAmenities);
          System.out.println("Amenities at this hotel are: ");
          int counter2 = 0;
          for (String s : amenitiesList) {
            counter2 = counter2 + 1;
            System.out.println(counter2 + ": " + s);
          }
        }

        case "5" -> {
          System.out.println("To get the hotel manager's contact information, " +
              "enter the number beside the desired hotel's city: ");
          List<String> allCitiesHotels = getAllHotels();
          int counter = 0;
          for (String s : allCitiesHotels) {
            counter = counter + 1;
            System.out.println(counter + ": " + s);
          }
          System.out.println("Enter the number: ");
          int hotelIdForManagerInfo = scanner.nextInt();
          String displayInfo = displayHotelManagerContactInfo(hotelIdForManagerInfo).toString();
          System.out.println(displayInfo);
        }

        case "6" -> {
          System.out.println("To get the information of all hotel manager's you need to" +
              "enter the \"admin\" username and password. ");
          System.out.println("Enter the admin username: ");
          String inAdminUsername = scanner.next();

          System.out.println("Enter the admin password: ");
          String inAdminPassword = scanner.next();

          if(inAdminUsername.equals(adminUsername) &&
          inAdminPassword.equals(adminPassword)) {
            System.out.println("Correct credentials.");
            System.out.println("Here's the required information: ");
            displayHotelManagersInfoAdmin();
          } else {
            System.out.println("Wrong credentials.");
          }
        }

        case "Q" -> {
          System.out.println("Program ended.");
          System.exit(0);
        }
        default -> System.out.println("Program ended.");
      }

    }
  }
}
