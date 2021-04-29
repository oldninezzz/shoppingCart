package DAO;
import VO.Book;
import VO.ShopInfo;
import VO.Userinfo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;

public class DBoperation {
    private Connection conn = null;
    private Statement stat = null;
    private ResultSet rs = null;
    private PreparedStatement prestat = null;
//    public DBoperation() throws Exception{
//        DBConnect connection = new DBConnect();
//        conn = connection.getConnection();
//    }
//    public static void main(String[] args) throws Exception {
//        DBoperation db = new DBoperation();
//        HashMap<String, Object> books;
//        books = db.getAllDatas();
//        System.out.println(books);
//    }
    public void initConn() throws Exception{
        DBConnect connection = new DBConnect();
        conn = connection.getConnection();
    }
    public HashMap getAllDatas() throws Exception{
        this.initConn();
        String sql = "select * from book";
        HashMap<String, Object> hashmap = new HashMap<String, Object>();
        try{
            this.stat = this.conn.createStatement();
            this.rs = this.stat.executeQuery(sql);
            while(this.rs.next()){
                Book book = new Book();
                book.setBookno(rs.getString("bookno"));
                book.setBookname(rs.getString("bookname"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getFloat("bookprice"));
                book.setStock(rs.getInt("stock"));
//                System.out.println(rs.getString("bookname"));
                hashmap.put(book.getBookno(), book);
            }
        }
        catch (Exception e){

        }finally {
            this.conn.close();
        }
        return hashmap;
    }
    public HashMap getAllUsers() throws Exception{
        this.initConn();
        String sql = "select * from userinfo";
        HashMap<String, Object> hashmap = new HashMap<String, Object>();
        try{
            this.stat = this.conn.createStatement();
            this.rs = this.stat.executeQuery(sql);
            while(this.rs.next()){
                Userinfo user = new Userinfo();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                hashmap.put(user.getUsername(), user);
            }
        }
        catch (Exception e){

        }finally {
            this.conn.close();
        }
        return hashmap;
    }
    public void insertUserinfo(Userinfo user) throws Exception{
        this.initConn();
        String sql = "insert into userinfo(username, password) values(?,?)";
        this.prestat = this.conn.prepareStatement(sql);
        this.prestat.setString(1, user.getUsername());
        this.prestat.setString(2, user.getPassword());
        this.prestat.executeUpdate();
        this.prestat.close();
        this.conn.close();
    }
    public String isExisted(String username) throws Exception{
        this.initConn();
        String sql = "select password from userinfo where username=(?)";
        this.prestat = this.conn.prepareStatement(sql);
        this.prestat.setString(1, username);
        this.rs = this.prestat.executeQuery();
        String pwd = "not registered";
        if(rs.next()){
            pwd = rs.getString("password");
        }
        this.prestat.close();
        this.conn.close();
        return pwd;
    }
    public int getCount(String username) throws Exception{
        this.initConn();
        String sql = "select sum(chosenNum) from shopinfo where username = '"+username+"'";
        this.stat = conn.createStatement();
        this.rs = stat.executeQuery(sql);
        int count = 0;
        if(rs.next())
            count = rs.getInt(1);
        this.stat.close();
        this.conn.close();
        return count;
    }
    public void deleteBook(String bookname, String username) throws Exception{
        this.initConn();
        String sql1 = "select chosenNum from shopinfo where username='"+username+"'and bookname='"+bookname+"'";
        String sql2 = "update shopinfo set chosenNum = chosenNum - 1 where username = ? and bookname = ?";
        String sql3 = "delete from shopinfo where username = ? and bookname = ?";
        String stockadd = "update book set stock = stock + 1 where bookname = '"+bookname+"'";
        stat = conn.createStatement();
        Statement stat2 = conn.createStatement();
        stat2.executeUpdate(stockadd);
        ResultSet rs = stat.executeQuery(sql1);
        if(rs.next()){
            if (rs.getInt(1) > 1){
                PreparedStatement ps1 = conn.prepareStatement(sql2);
                ps1.setString(1, username);
                ps1.setString(2, bookname);
                ps1.executeUpdate();
                ps1.close();
            }
            else{
                PreparedStatement ps2 = conn.prepareStatement(sql3);
                ps2.setString(1, username);
                ps2.setString(2, bookname);
                ps2.executeUpdate();
                ps2.close();
            }
        }
        stat2.close();
        stat.close();
        conn.close();
    }
    public void deleteAll(String username) throws Exception{
        this.initConn();
        String sql = "delete from shopinfo where username = '"+username+"'";
        String stockaddall1 = "select bookname from shopinfo where username = '"+username+"'";
        Statement stat2 = conn.createStatement();
        this.stat = conn.createStatement();
        rs = stat2.executeQuery(stockaddall1);
        Statement stat3 = conn.createStatement();

        while(rs.next()){
            String stockaddall2 = "update book set stock = stock + (select chosenNum from shopinfo where bookname = '"+rs.getString(1)+"' and username = '"+username+"') where bookname = '"+rs.getString(1)+"'";
            stat3.executeUpdate(stockaddall2);
        }
        stat2.close();
        stat3.close();
        stat.executeUpdate(sql);
        stat.close();
        conn.close();
    }
    public void addBook(String bookname, String username) throws Exception{
        this.initConn();
        String sql1 = "select * from shopinfo where bookname = '"+bookname+"'and username='"+username+"'";
        String stocksub = "update book set stock = stock - 1 where bookname = '"+bookname+"'";
//        String sql1 = "select * from shopinfo";
        stat = conn.createStatement();
        Statement stat2 = conn.createStatement();
        stat2.executeUpdate(stocksub);
        rs = stat.executeQuery(sql1);
        if(rs.next()){
            String sql2 = "update shopinfo set chosenNum = chosenNum + 1 where bookname = ? and username = ?";
            prestat = conn.prepareStatement(sql2);
            prestat.setString(1, bookname);
            prestat.setString(2, username);
            prestat.executeUpdate();
            prestat.close();
            conn.close();
        }
        else{
            String sql2 = "insert into shopinfo values(?,?,?)";
            prestat = conn.prepareStatement(sql2);
            prestat.setString(1, username);
            prestat.setString(3, bookname);
            prestat.setInt(2, 1);
            prestat.executeUpdate();
            prestat.close();
            conn.close();
        }
        stat2.close();
        stat.close();
        conn.close();
    }
    public int getBookStock(String bookname) throws Exception{
        this.initConn();
        String sql = "select stock from book where bookname = '"+bookname+"'";
        stat = conn.createStatement();
        rs = stat.executeQuery(sql);
        int nu = 0;
        if(rs.next())
            nu = rs.getInt(1);
        stat.close();
        conn.close();
        return nu;
    }
    public void setBookNum(String username, String bookname, int num) throws Exception{
        this.initConn();
        String sql3 = "select chosenNum from shopinfo where bookname = '"+bookname+"' and username = '"+username+"'";
        String sql1 = "update shopinfo set chosenNum = "+num+" where bookname = '"+bookname+"' and username = '"+username+"'";


        stat = conn.createStatement();
        Statement stat3 = conn.createStatement();
        rs = stat3.executeQuery(sql3);
        int cn = 0;
        if(rs.next())
            cn = rs.getInt(1);
        stat.executeUpdate(sql1);
        String sql2 = "update book set stock = stock - "+(num-cn)+" where bookname = '"+bookname+"'";
        Statement stat2 = conn.createStatement();

        stat2.executeUpdate(sql2);
        stat.close();
        stat2.close();
        conn.close();

    }
    public String getBookno(String bookname) throws Exception{
        this.initConn();
        String sql = "select bookno from book where bookname = '"+bookname+"'";
        this.stat = conn.createStatement();
        this.rs = stat.executeQuery(sql);
        String bookno = null;
        if(rs.next())
            bookno = rs.getString(1);
        stat.close();
        conn.close();
        return bookno;
    }
    public HashMap getShopInfo(String username) throws Exception{
        this.initConn();
        String sql1 = "select shopinfo.bookname, bookprice, chosenNum from shopinfo join book on shopinfo.bookname = book.bookname where username = '"+username+"'";
//        String sql2 = "select bookprice from book where bookname in (select bookname from shopinfo where username = '"+username+"')";
//        Statement stat2 = conn.createStatement();
        this.stat = conn.createStatement();
        this.rs = stat.executeQuery(sql1);
//        ResultSet rs2 = stat2.executeQuery(sql2);
        HashMap<String, ShopInfo> shopinfo = new HashMap<String, ShopInfo>();
        while (rs.next()){
//            rs2.next();
            ShopInfo si = new ShopInfo();
            si.setBookname(rs.getString("bookname"));
//            si.setPrice(rs2.getFloat(1));
            si.setPrice(rs.getFloat("bookprice"));
            si.setBuynum(rs.getInt("chosenNum"));
            shopinfo.put(rs.getString("bookname"), si);
        }
        stat.close();
//        stat2.close();
        conn.close();
        return shopinfo;

    }
    public float getTotalPay(String username) throws Exception{
        this.initConn();
        String sql1 = "select bookprice from shopinfo join book on shopinfo.bookname = book.bookname where username = '"+username+"'";
        String sql2 = "select chosenNum from shopinfo where username='"+username+"'";
        this.stat = conn.createStatement();
        Statement stat2 = conn.createStatement();
        rs = stat.executeQuery(sql1);
        ResultSet rs2 = stat2.executeQuery(sql2);
        float tp = 0;
        while(rs.next()){
            rs2.next();
            tp += rs.getFloat(1)*rs2.getInt(1);
        }
        stat.close();
        conn.close();
        return tp;
    }
}
