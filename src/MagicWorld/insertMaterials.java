package MagicWorld;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class insertMaterials {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String jdbcDriver = "jdbc:mariadb://localhost:3306/magicworld";
		String dbUser = "root";
		String dbPass = "8787";
		
		String insert_values_materials =
				"Insert into Materials(Name, Origin, Type, Price, MagicID,ShopID)"
				+ "values (?,?,?,?,?,?)";
		
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
			preStmt = conn.prepareStatement(insert_values_materials);
			//������ stmt�� ����� sql���� �־ �����Ų �Ͱ� �޸� sql���� �־ prestmt�� �����ϰ� �Ŀ� �����Ŵ.
			
			String [] Name = {"Potato", "RedPortion", "Apple"};
			String[] Origin = {"Wonju", "Sejong", "Incheon"};
			String [] Type = {"Vegetablility","Animality","Mineral"};
			int [] Price = {10, 40, 15};
			int [] MagicID = {1, 2, 3};
			int [] ShopID = {1, 2, 3};
			
			for(int i=0;i<Name.length;i++) {
				preStmt.setString(1, Name[i]);
				preStmt.setString(2, Origin[i]);
				preStmt.setString(3, Type[i]);
				preStmt.setInt(4, Price[i]);
				preStmt.setInt(5, MagicID[i]);
				preStmt.setInt(6, ShopID[i]);
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
