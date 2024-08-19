class AppStringConstants {
  //Common
  static const String appName = 'Saravana Bhavan';
  static const String om = 'Om';
  static const String saravanaBhavan = 'Saravana Bhavan';
  static const String pureVegeterian = 'Pure Vegetarian';
  static const String tasteOfHome = 'Taste\nof\nHome';
  static const String welcomeBack = 'Welcome back';
  static const String emailAddress = 'Email address';
  static const String enterEmailAddress = 'Enter the email address';
  static const String password = 'Password';
  static const String enterPassword = 'Enter the password';
  static const String login = 'Login';
  static const String labours = 'Labours';
  static const String dining = 'Dining';
  static const String bonus = 'Bonus';
  static const String attendance = 'Attendance';
  static const String dashed = '--';
  static const String asterick = ' *';
  static const String cancel = 'Cancel';
  static const String submit = 'Submit';
  static const String update = 'Update';
  static const String delete = 'Delete';
  static const String rupeeSymbol = '₹';
  static const String yes = 'Yes';
  static const String no = 'No';

  //Orders
  static const String dineIn = "Dine-in";
  static const String orders = 'Orders';
  static const String orderDetails = "Order details";
  static const String newOrder = 'New order';
  static const String modifyOrder = 'Modify order';
  static const String activeOrders = 'Active orders';
  static const String openBills = 'Open bills';
  static const String closedBills = 'Closed bills';
  static const String placeOrder = 'Place order';
  static const String reviewOrder = 'Review order';
  static const String confirmOrder = 'Confirm order';
  static const String addItem = 'Add';
  static const String orderPrice = 'Order price';

  //Employee
  static const String employees = 'Employees';
  static const String role = 'Role';
  static const String enterRole = 'Select the employee role';
  static const String employeeName = 'Employee name';
  static const String enterEmployeeName = 'Enter the employee name';
  static const String salaryDay = 'Salary / Day';
  static const String enterSalary = 'Enter the salary';
  static const String dateOfJoining = 'Date of joining';
  static const String enterDateOfJoin = 'Select the date of joining';
  static const String gender = 'Gender';
  static const String male = 'Male';
  static const String female = 'Female';
  static const int valueZero = 0;
  static const String men = 'Men';
  static const String women = 'Women';
  static const String total = 'Total';
  static const String workingFrom = 'Working from ';
  static const String perDay = ' / day';
  static const String noEmployees = 'Employees not found';

  //Tables
  static const String table = 'Table';
  static const String tableName = 'Table name';
  static const String enterTableName = 'Enter the table name';
  static const String selectTableName = 'Select the table name';
  static const String waiterName = 'Waiter name';
  static const String waiter = 'Waiter';
  static const String selectWaiterName = 'Select the waiter name';
  static const String occupantsCount = 'Occupants count';
  static const String occupancy = 'Occupancy';
  static const String enterOccupantsCount = 'Enter the occupants count';
  static const String noTables = 'Tables not found';
  static const String totalItems = 'Total items';

  //Menu
  static const String menu = 'Menu';
  static const String searchMenu = 'Search menu item';
  static const String searchMenuKey = 'menuItem';
  static const String categories = 'Categories';
  static const String itemCategory = 'Item category';
  static const String selectItemCategory = 'Select the item category';
  static const String itemName = 'Item name';
  static const String enterItemName = 'Enter the item name';
  static const String itemPrice = 'Item price / qty';
  static const String enterItemPrice = 'Enter the item price / qty';
  static const String itemAvailable = 'Item available';
  static const String noMenuItem = 'Menu Items not found';

  static const List<String> genderArray = [male, female];

  static const List<String> roleArray = [
    'Waiter',
    'Cleaner',
    'Main master',
    'Dosa master',
    'Dish wash cleaner',
    'Hall staff',
  ];

  static const List<String> foodCategoryArray = [
    'Breakfast',
    'Dosa',
    'Lunch',
    'Dinner',
    'Drink',
  ];
}

class TableNames {
  static const String employeeDetailsTable = 'employee_details';
  static const String tableDetailsTable = 'table_details';
  static const String menuDetailsTable = 'menu_details';
  static const String dineInDetailsTable = 'dine_in_order_details';
}

class SheetNames {
  static const String add = 'add';
  static const String edit = 'edit';
}
