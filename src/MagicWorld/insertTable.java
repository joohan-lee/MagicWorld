package MagicWorld;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class insertTable {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String jdbcDriver = "jdbc:mariadb://localhost:3306/magicworld";
		String dbUser = "root";
		String dbPass = "8787";
		//String insert_value_single =
			//	"Insert into Persons (Age, Name) values (34,'john');";
		String insert_values_magics =
				"Insert into Magics(Name, Description, Class, Attribute, Type,"
				+ "Effectiveness, Mana_consumption, Price, WizardID, ShopID) "
				+ "values (?,?,?,?,?,?,?,?,?,?);";
		
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
			//Statement 생성
			//stmt = conn.createStatement();//connection 객체 통해 stmt생성
			//stmt.executeUpdate(insert_value_single);
			
			
			////////////////////////Insert into Magics
			preStmt = conn.prepareStatement(insert_values_magics);//connection 객체 통해 prestmt생성.
			//위에서 stmt를 만들고 sql문을 넣어서 실행시킨 것과 달리 sql문을 넣어서 prestmt를 생성하고 후에 실행시킴.
			
			String [] Name = {"HEAL", "THUNDERBOLT", "THUNDERCLAW", "ICEBEAM", "WINDSHOT"};
			//String [] Description = {"피 채워줌", "번개를 내리침","전기로 두번 긁음","고드름을 날림","바람으로 타격함"};
			String [] Description = {"Heal HP", "Lightening","Scratch twice","Shot Ice","Shot Wind"};
			int [] Class = {3,4,2,2,2};
			//String [] Attribute = {"불","전기","전기","얼음","바람"};
			String [] Attribute = {"Fire","Electricity","Electricity","Ice","Wind"};
			String [] Type = {"Healing","Attack","Attack","Attack","Attack"};
			int [] Effectiveness = {30, 60, 30, 35, 25};
			int [] Mana_consumption = {10, 30, 20, 25, 15};
			int [] Price = {100, 130, 40, 50, 30};
			int [] WizardID = {1,2,3,4,5};
			int [] ShopID = {1,2,3,4,5};
			
			for(int i=0;i<Name.length;i++) {
				preStmt.setString(1, Name[i]);
				preStmt.setString(2, Description[i]);
				preStmt.setInt(3, Class[i]);
				preStmt.setString(4, Attribute[i]);
				preStmt.setString(5, Type[i]);
				preStmt.setInt(6, Effectiveness[i]);
				preStmt.setInt(7, Mana_consumption[i]);
				preStmt.setInt(8, Price[i]);
				preStmt.setInt(9, WizardID[i]);
				preStmt.setInt(10, ShopID[i]);
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
