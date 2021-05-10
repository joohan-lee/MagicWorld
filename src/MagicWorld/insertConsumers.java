package MagicWorld;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class insertConsumers{

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String jdbcDriver = "jdbc:mariadb://localhost:3306/magicworld";
		String dbUser = "root";
		String dbPass = "8787";
		
		String insert_values_consumers =
				"Insert into consumers(Name, Age, Address, Attribute, Balance)"
				+ "values (?,?,?,?,?);";
		
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
			preStmt = conn.prepareStatement(insert_values_consumers);
			//������ stmt�� ����� sql���� �־ �����Ų �Ͱ� �޸� sql���� �־ prestmt�� �����ϰ� �Ŀ� �����Ŵ.
			
			String [] Name = {"Messi", "Neymar", "Kaka"};
			int [] Age = {24, 25, 32};
			String [] Address = {"Wonju","Gimhae","Changwon"};
			String [] Attribute = {"Water","Fire","Wind"};
			int [] Balance = {500000, 700000, 200000};
			
			for(int i=0;i<Name.length;i++) {
				preStmt.setString(1, Name[i]);
				preStmt.setInt(2, Age[i]);
				preStmt.setString(3, Address[i]);
				preStmt.setString(4, Attribute[i]);
				preStmt.setInt(5, Balance[i]);
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
