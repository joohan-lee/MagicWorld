package MagicWorld;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class insertShops {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String jdbcDriver = "jdbc:mariadb://localhost:3306/magicworld";
		String dbUser = "root";
		String dbPass = "8787";
		
		String insert_values_shops =
				"Insert into shops(ShopName, Address, ChiefName, PermitClass, ShopBalance)"
				+ "values (?,?,?,?,?)";
		
		Connection conn = null;
		Statement stmt = null;
		PreparedStatement preStmt= null;
		
		try {
			String driver = "org.mariadb.jdbc.Driver";
			try {
				Class.forName(driver);
			}catch(ClassNotFoundException e) {
				e.printStackTrace();
			}
			//DB Connection ����
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			////////////////////////Insert into Wizards
			preStmt = conn.prepareStatement(insert_values_shops);
			//������ stmt�� ����� sql���� �־ �����Ų �Ͱ� �޸� sql���� �־ prestmt�� �����ϰ� �Ŀ� �����Ŵ.
			
			String [] ShopName = {"Ashely", "Vips", "7springs"};
			String[] Address = {"Wonju", "Sejong", "Incheon"};
			String [] ChiefName = {"Ronald","John","Lucas"};
			int [] PermitClass = {3, 4, 2};
			int [] ShopBalance = {50000000, 70000000, 80000000};
			
			for(int i=0;i<ShopName.length;i++) {
				preStmt.setString(1, ShopName[i]);
				preStmt.setString(2, Address[i]);
				preStmt.setString(3, ChiefName[i]);
				preStmt.setInt(4, PermitClass[i]);
				preStmt.setInt(5, ShopBalance[i]);
				preStmt.executeUpdate();
				preStmt.clearParameters();//�տ� ������ preStmt�� ?,? �ڸ��� ���������Ƿ� clear��Ű�� �ٽ� �־����, �ٵ� �������� �������..
			}
			
			
			
			
			System.out.println("insert����");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				preStmt.close();
				stmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}

		
	}

}
