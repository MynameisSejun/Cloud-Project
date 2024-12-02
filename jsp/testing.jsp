<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tomcat & MySQL 연동 테스트</title>
</head>
<body>
    <h1>데이터베이스 연결 테스트</h1>
    
    <%
        // 로그를 저장할 StringBuilder
        StringBuilder log = new StringBuilder();
        
        try {
            log.append("1. MySQL JDBC 드라이버 로드 시도<br>");
            Class.forName("com.mysql.cj.jdbc.Driver");
            log.append("✅ MySQL JDBC 드라이버 로드 성공<br><br>");
            
            String jdbcDriver = "jdbc:mysql://localhost:3306/runningApp?serverTimezone=UTC";
            String dbUser = "root";
            String dbPass = "1234";
            
            log.append("2. 데이터베이스 연결 시도<br>");
            log.append("URL: ").append(jdbcDriver).append("<br>");
            log.append("User: ").append(dbUser).append("<br>");
            
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
                log.append("✅ 데이터베이스 연결 성공<br><br>");
                
                log.append("3. SQL 쿼리 실행 시도<br>");
                String query = "SELECT name FROM Users";
                log.append("실행할 쿼리: ").append(query).append("<br>");
                
                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);
                log.append("✅ SQL 쿼리 실행 성공<br><br>");
                
                log.append("4. 조회된 데이터:<br>");
                %>
                <table width="100%" border="1" cellspacing="0" cellpadding="5">
                    <thead>
                        <tr>
                            <th>이름</th>
                        </tr>
                    </thead>
                    <tbody>
                <%
                int rowCount = 0;
                while (rs.next()) {
                    rowCount++;
                    String name = rs.getString("name");
                    %>
                    <tr>
                        <td><%= name %></td>
                    </tr>
                    <%
                }
                log.append("총 ").append(rowCount).append("개의 데이터가 조회됨<br>");
                
            } catch (SQLException ex) {
                log.append("❌ SQL 에러 발생:<br>");
                log.append("에러 메시지: ").append(ex.getMessage()).append("<br>");
                log.append("SQL 상태: ").append(ex.getSQLState()).append("<br>");
                log.append("에러 코드: ").append(ex.getErrorCode()).append("<br>");
            } finally {
                log.append("<br>5. 리소스 정리<br>");
                if (rs != null) try { 
                    rs.close(); 
                    log.append("✅ ResultSet 정리 완료<br>");
                } catch (SQLException ex) { 
                    log.append("❌ ResultSet 정리 중 에러: ").append(ex.getMessage()).append("<br>");
                }
                if (stmt != null) try { 
                    stmt.close(); 
                    log.append("✅ Statement 정리 완료<br>");
                } catch (SQLException ex) { 
                    log.append("❌ Statement 정리 중 에러: ").append(ex.getMessage()).append("<br>");
                }
                if (conn != null) try { 
                    conn.close(); 
                    log.append("✅ Connection 정리 완료<br>");
                } catch (SQLException ex) { 
                    log.append("❌ Connection 정리 중 에러: ").append(ex.getMessage()).append("<br>");
                }
            }
            
        } catch (ClassNotFoundException e) {
            log.append("❌ JDBC 드라이버 로드 실패:<br>");
            log.append("에러 메시지: ").append(e.getMessage()).append("<br>");
        }
    %>
    </tbody>
    </table>
    
    <h2>실행 로그</h2>
    <div style="border: 1px solid #ccc; padding: 10px; margin-top: 20px;">
        <%= log.toString() %>
    </div>
</body>
</html>
