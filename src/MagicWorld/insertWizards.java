package MagicWorld;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class insertWizards {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String jdbcDriver = "jdbc:mariadb://localhost:3306/magicworld";
		String dbUser = "root";
		String dbPass = "8787";
		
		String insert_values_wizards =
				"Insert into Wizards(Name, Age, Tribe, Hometown, Occupation,"
				+ "Class, Attribute, Mana, Balance)"
				+ "values (?,?,?,?,?,?,?,?,?)";
		
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
			preStmt = conn.prepareStatement(insert_values_wizards);
			//위에서 stmt를 만들고 sql문을 넣어서 실행시킨 것과 달리 sql문을 넣어서 prestmt를 생성하고 후에 실행시킴.
			
			String [] Name = {"Scamander", "Potter", "Dumbledore"};
			int [] Age = {29, 24, 352};
			String[] Tribe = {"Human", "Elf", "Dwarf"};
			String [] Hometown = {"Wonju","Busan","Seoul"};
			String [] Occupation = {"Cleric","Student","Professor"};
			int [] Class = {7, 4, 10};
			String [] Attribute = {"Dark","Wind","Fire"};
			int [] Mana = {7000, 3000, 10000};
			int [] Balance = {100000, 40000, 500000};
			
			for(int i=0;i<Name.length;i++) {
				preStmt.setString(1, Name[i]);
				preStmt.setInt(2, Age[i]);
				preStmt.setString(3, Tribe[i]);
				preStmt.setString(4, Hometown[i]);
				preStmt.setString(5, Occupation[i]);
				preStmt.setInt(6, Class[i]);
				preStmt.setString(7, Attribute[i]);
				preStmt.setInt(8, Mana[i]);
				preStmt.setInt(9, Balance[i]);
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
