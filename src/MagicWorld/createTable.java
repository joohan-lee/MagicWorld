package MagicWorld;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class createTable {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/magicworld";
		String dbUser = "root";
		String dbPass = "8787";
		String create_Magics_table = " create table IF NOT EXISTS Magics( MagicID int NOT NULL primary key AUTO_INCREMENT, "
				+ "Name varchar(255), "
				+ "Description varchar(255), Class int, Attribute varchar(20), Type varchar(20), "
				+ "Effectiveness int, Mana_consumption int, Price int,"
				+ "CreatorID varchar(15),"
				+ "foreign key(CreatorID) references Wizards(WizardID), "
				//+ "foreign key(ShopID) references Shops(ShopID), "
				+ "check(Class >= 1 AND Class <=10), "
				+ "check( Effectiveness >=1 and Effectiveness <=100));";
		
		String create_Wizards_table = "create table IF NOT EXISTS Wizards( WizardID varchar(15) NOT NULL primary key,"
				+ "Password varchar(15) not null,"
				+ "Name varchar(255), Age int, Tribe varchar(20),"
				+ "Hometown varchar(20), Occupation varchar(20),"
				+ "Class int, Attribute varchar(20), Mana int, "
				+ "Balance int,"
				+ "check(Class >= 1 AND Class <=10));";
		
		String create_Materials_table = "create table IF NOT EXISTS Materials(MaterialID int NOT NULL primary key AUTO_INCREMENT,"
				+ "Name varchar(255), Origin varchar(20), Type varchar(20),"
				+ "Price int);";
				//+ "foreign key(MagicID) references Magics(MagicID),"
				//+ "foreign key(ShopID) references Shops(ShopID));";
		
		String create_Shops_table = "create table IF NOT EXISTS Shops(ShopID varchar(15) NOT NULL primary key,"
				+ "Password varchar(15) NOT NULL,"
				+ "ShopName varchar(255), Address varchar(255), ChiefName varchar(255), "
				+ "PermitClass int, ShopBalance int,"
				+ "check(PermitClass >=1 AND PermitClass <=10));";
		
		String create_Customers_table = "create table IF NOT EXISTS Customers(CustomerID varchar(15) NOT NULL primary key,"
				+ "Password varchar(15) NOT NULL,"
				+ "Name varchar(255), Age int, Address varchar(255),"
				+ "Attribute varchar(20), Balance int)";
		
		String create_Belongings_table = "create table IF NOT EXISTS Belongings(ShopID varchar(15) NOT NULL, "
				+ "WizardID varchar(15) NOT NULL,"
				+ "primary key(ShopID, WizardID),"
				+ "foreign key(ShopID) references Shops(ShopID),"
				+ "foreign key(WizardID) references Wizards(WizardID));";
		
		String create_Clients_table = "create table IF NOT EXISTS Clients(ShopID varchar(15) NOT NULL,"
				+ "CustomerID varchar(15) NOT NULL,"
				+ "primary key(ShopID, CustomerID),"
				+ "foreign key(CustomerID) references Customers(CustomerID), "
				+ "foreign key(ShopID) references Shops(ShopID)); ";
		
		String create_Sales_table = "create table IF NOT EXISTS Sales(ShopID varchar(15) NOT NULL,"
				+ "MaterialID int NOT NULL,"
				+ "Stock int,"
				+ "primary key(ShopID, MaterialID),"
				+ "foreign key(ShopID) references Shops(ShopID),"
				+ "foreign key(MaterialID) references Materials(MaterialID));";
		
		String create_Requisites_table = "create table IF NOT EXISTS Requisites(MagicID int NOT NULL,"
				+ "MaterialID int NOT NULL,"
				+ "Requirement int,"
				+ "primary key(MagicID, MaterialID),"
				+ "foreign key(MagicID) references Magics(MagicID),"
				+ "foreign key(MaterialID) references Materials(MaterialID));";
		
		try {
			
			String driver = "org.mariadb.jdbc.Driver";
			try {
				Class.forName(driver);
			}catch(ClassNotFoundException e) {
				e.printStackTrace();
			}
			//DB Connection 积己
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			//Statement 积己
			stmt = conn.createStatement();//connection 按眉烹秦 stmt 积己
			stmt.executeUpdate(create_Magics_table);
			stmt.executeUpdate(create_Wizards_table);
			stmt.executeUpdate(create_Materials_table);
			stmt.executeUpdate(create_Shops_table);
			stmt.executeUpdate(create_Customers_table);
			stmt.executeUpdate(create_Belongings_table);
			stmt.executeUpdate(create_Clients_table);
			stmt.executeUpdate(create_Sales_table);
			stmt.executeUpdate(create_Requisites_table);
			
			System.out.println("create己傍");
			//Query 角青
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}

		
	}

}
