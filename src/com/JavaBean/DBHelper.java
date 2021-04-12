package com.JavaBean;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.mysql.jdbc.Statement;

/**
 * 数据库工具类 说明：不支持事务。。。。。。。。
 * 
 * @version 0.3
 * @createTime 2020-07-24 2020-7-30 第一次修改 2020-8-01 第二次修改
 */
public class DBHelper {
	static Connection conn;
	static PreparedStatement ps;
	static ResultSet rs;
	static String drivername = "com.mysql.jdbc.Driver";
	static String username = "root";
	static String userpwd = "995716";
	static String dbName = "eshop";
	static String url = "jdbc:mysql://localhost:3306/" + dbName + "?useSSL=false";
	private static int count = 0;
	private static int totalpages = 0;

	static {
		// 加载驱动。。。。把Driver加载进内存，，。。。
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 获取连接
	 */
	private static void connection() {
		try {
			conn = DriverManager.getConnection(url,username,userpwd);
		} catch (SQLException e) {

			e.printStackTrace();
		}
	}

	/**
	 * 关闭连接
	 */
	private static void close() {

		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 查询商品总数量
	 */
	public static int getCount(int num) {
		try {
			connection();
			String sql = "SELECT COUNT(1) FROM commodities WHERE typeid="+num+" AND state=TRUE";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			// 绑定参数
			rs.next();
			count = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return count;
	}

	/**
	 * 计算总页数
	 * 
	 * @param pageSize 每页显示数量
	 * @return 计算后的页数
	 */
	public static int getTotalpages(int pageSize) {
		if (count % pageSize == 0) {
			totalpages = count / pageSize;
		} else {
			totalpages = count / pageSize + 1;
		}
		System.out.println(totalpages);
		return totalpages;
	}
	/**
	 * 首页查询商品
	 * */
	public static List<Commodities> Commodities(String sql) {
		List<Commodities> commodityList = new ArrayList<Commodities>();
		try {
			connection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				Commodities commodity = new Commodities();
				commodity.setCommodityid(rs.getInt("commodityid"));
				commodity.setTypeid(rs.getInt("typeid"));
				commodity.setTypename(rs.getString("typename"));
				commodity.setName(rs.getString("name"));
				commodity.setPrice(rs.getDouble("price"));
				commodity.setPicture(rs.getString("picture"));
				commodity.setState(rs.getBoolean("state"));
				commodityList.add(commodity);
			}
		}
		catch (SQLException exception) {
			exception.printStackTrace();
		}
		finally {
			close();
		}
		return commodityList;
	}

	/**
	 * 登录
	 * @return true或false
	 * */
	public static List<Users> Login(String sql) throws Exception{
		List<Users> userList = new ArrayList<Users>();
		try {
			connection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				Users Login = new Users();
				Login.setUserid(rs.getInt("userid"));
				Login.setNickname(rs.getString("nickname"));
				userList.add(Login);
			}
		}
		catch (SQLException exception) {
			exception.printStackTrace();
		}
		finally {
			close();
		}
		return userList;
	}
	
	/**
	 * 增删改操作
	 * 
	 * @return 返回执行行数
	 */
	public static int executeUpdate(String sql) {
		
		try {
			connection();
			ps = conn.prepareStatement(sql);
			return ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return 0;
	}

	/**
	 * 个人信息
	 */
	public static List<Users> Profile(String sql) {
		List<Users> userList = new ArrayList<Users>();
		try {
			connection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				Users profile = new Users();
				profile.setNickname(rs.getString("nickname"));
				profile.setName(rs.getString("name"));
				profile.setTelephone(rs.getString("telephone"));
				profile.setMail(rs.getString("mail"));
				profile.setAddress(rs.getString("address"));
				userList.add(profile);
			}
		}
		catch (SQLException exception) {
			exception.printStackTrace();
		}
		finally {
			close();
		}
		return userList;
	}
	
	/**
	 * 购物车
	 * */
	public static List<Commodities> Cart(String sql) {
		List<Commodities> commodityList = new ArrayList<Commodities>();
		try {
			connection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				Commodities commodity = new Commodities();
				commodity.setCommodityid(rs.getInt("commodityid"));
				commodity.setName(rs.getString("name"));
				commodity.setPrice(rs.getDouble("price"));
				commodity.setPicture(rs.getString("picture"));
				commodity.setNumber(rs.getInt("number"));
				commodityList.add(commodity);
			}
		}
		catch (SQLException exception) {
			exception.printStackTrace();
		}
		finally {
			close();
		}
		return commodityList;
	}
	
	/**
	 * 购物车
	 * */
	public static int Cart(int uid,int cid) {
		String sql = "SELECT * FROM cart WHERE userid='"+uid+"' and commodityid='"+cid+"'";
		try {
			connection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt("number");
			}
		}
		catch (SQLException exception) {
			exception.printStackTrace();
		}
		finally {
			close();
		}
		return 0;
	}
	
	/**
	 * 当前用户订单查询
	 */
	public static List<Orders> Orders(String sql) {
		List<Orders> OrderList = new ArrayList<Orders>();
		try {
			connection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				Orders Order = new Orders();
				Order.setOrderid(rs.getString("orderid"));
				Order.setTime(rs.getString("time"));
				Order.setPrice(rs.getDouble("price"));
				Order.setState(rs.getBoolean("state"));
				OrderList.add(Order);
			}
		}
		catch (SQLException exception) {
			exception.printStackTrace();
		}
		finally {
			close();
		}
		return OrderList;
	}
	/**
	 * 当前订单商品查询
	 */
	public static List<OrderProduct> OrderCommodities(String sql) {
		List<OrderProduct> OrderProductList = new ArrayList<OrderProduct>();
		try {
			connection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				OrderProduct OrderCommodities = new OrderProduct();
				OrderCommodities.setName(rs.getString("name"));
				OrderCommodities.setPrice(rs.getDouble("price"));
				OrderCommodities.setPicture(rs.getString("picture"));
				OrderCommodities.setOrderid(rs.getString("orderid"));
				OrderCommodities.setCommodityid(rs.getInt("commodityid"));
				OrderCommodities.setNumber(rs.getInt("number"));
				OrderProductList.add(OrderCommodities);
			}
		}
		catch (SQLException exception) {
			exception.printStackTrace();
		}
		finally {
			close();
		}
		return OrderProductList;
	}
	
	/**
	 * 增、删、改操作
	 * 
	 * @param sql    sql
	 * @param params sql中的参数
	 * @return 受影响行数
	 */
	public static int executeUpdate(String sql, Object... params) {

		try {
			// 获取连接。。。。
			connection();
			// 获取句柄
			ps = conn.prepareStatement(sql);
			// 绑定参数
			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					ps.setObject(i + 1, params[i]);
				}
			}
			// 执行sql
			return ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 关闭连接。。。。
			close();
		}
		return 0;
	}

	/**
	 * 添加数据并返回自增的主键
	 * 
	 * @param sql
	 * @param params
	 * @return 自增的id
	 */
	public static int addAndReturnKey(String sql, Object... params) {

		try {
			// 获取连接。。。。
			connection();
			// 获取句柄
			ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			// 绑定参数
			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					ps.setObject(i + 1, params[i]);
				}
			}
			// 执行sql
			ps.executeUpdate();
			// 获取插入后的自增主键
			ResultSet res = ps.getGeneratedKeys();
			if (res.next()) {
				return res.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 关闭连接。。。。
			close();
		}
		return 0;
	}

	/**
	 * 查询单行内容
	 * 
	 * @param <T>    封装的返回值对象类型
	 * @param clazz  返回值class对象
	 * @param sql    sql语句
	 * @param params sql参数
	 * @return 查询结果
	 */
	public static <T> T executeQryOne(Class<T> clazz, String sql, Object... params) {

		List<T> arr = executeQryList(clazz, sql, params);

		return arr.size() > 0 ? arr.get(0) : null;
	}

	/**
	 * 查询多行内容
	 * 
	 * @param <T>    封装的返回值对象类型
	 * @param clazz  返回值class对象
	 * @param sql    sql语句
	 * @param params sql参数
	 * @return 查询结果List
	 */
	public static <T> List<T> executeQryList(Class<T> clazz, String sql, Object... params) {
		List<T> arr = new ArrayList<T>();
		// 获取连接。。。。。
		connection();
		// 获取句柄
		try {
			ps = conn.prepareStatement(sql);
			// 绑定参数
			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					ps.setObject(i + 1, params[i]);
				}
			}
			// 查询
			rs = ps.executeQuery();

			while (rs.next()) {
				// 获取到类的属性（对应数据库表中的列名）
				Field[] fs = clazz.getDeclaredFields();
				T t = clazz.getDeclaredConstructor().newInstance();
				// 将数据封装到 对象中
				for (Field f : fs) {
					// 类的属性名
					String colName = f.getName();

					// 2020-08-01 查询列是否存在 - 张 - begin

					if (!hasCol(colName, rs)) {
						continue;
					}
					// 2020-08-01 查询列是否存在 -张- end

					Object colVal = rs.getObject(colName);

					String setMethodName = "set" + colName.substring(0, 1).toUpperCase() + colName.substring(1);
					// 获取改属性的set方法
					Method m = clazz.getDeclaredMethod(setMethodName, f.getType());
					// 执行set方法
					m.invoke(t, colVal);
				}
				arr.add(t);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 关闭连接。。。。
			close();
		}

		return arr;
	}

	public static int qryCount(String sql, Object... params) {
		connection();
		// 获取句柄
		try {
			ps = conn.prepareStatement(sql);
			// 绑定参数
			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					ps.setObject(i + 1, params[i]);
				}
			}
			// 查询
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 关闭连接。。。。
			close();
		}
		return 0;
	}

	/**
	 * 2020-08-01 数据库中判断是否有该列
	 * 
	 * @param colName 列的名称
	 * @param rs      数据库列名的集合
	 * @return true 有 false 没有
	 */
	private static boolean hasCol(String colName, ResultSet rs) {
		try {
			rs.findColumn(colName);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
}