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
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			////////////////////////Insert into Wizards
			preStmt = conn.prepareStatement(insert_values_shops);
			//위에서 stmt를 만들고 sql문을 넣어서 실행시킨 것과 달리 sql문을 넣어서 prestmt를 생성하고 후에 실행시킴.
			
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
				preStmt.clearParameters();//앞에 넣은게 preStmt의 ?,? 자리에 남아있으므로 clear시키고 다시 넣어야함, 근데 안지워도 결과같네..
			}
			
			
			
			
			System.out.println("insert성공");
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
