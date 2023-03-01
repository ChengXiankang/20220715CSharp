﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

//1-支持参数化传递
namespace Demo05
{
    class DBHelper
    {
        public static string connStr = ConfigurationManager.ConnectionStrings["junjunConn"].ConnectionString;
        public static SqlConnection conn = null;
        public static SqlCommand cmd = null;
        public static SqlDataAdapter adp = null;

        #region 连接数据库
        public static void OpenConn()
        {
            if (conn == null)
            {
                conn = new SqlConnection(connStr);
                conn.Open();
            }
            if (conn.State == System.Data.ConnectionState.Closed)
            {
                conn.Open();
            }
            if (conn.State == System.Data.ConnectionState.Broken)
            {
                conn.Close();
                conn.Open();
            }
        }
        #endregion

        #region 准备执行一个Command命令
        public static void PrepareCmd(string sql)
        {
            OpenConn(); //打开数据库连接
            cmd = new SqlCommand(sql, conn);
        }
        public static void PrepareCmdProc(string sql)
        {
            OpenConn(); //打开数据库连接
            cmd = new SqlCommand(sql, conn);
            cmd.CommandType = CommandType.StoredProcedure;
        }
        #endregion

        #region 准备执行一个断开模式查询
        public static void PrepareDataTable(string sql)
        {
            OpenConn(); //打开数据库连接
            adp = new SqlDataAdapter(sql, conn);
        }
        public static void PrepareDataTableProc(string sql)
        {
            OpenConn(); //打开数据库连接
            adp = new SqlDataAdapter(sql, conn);
            adp.SelectCommand.CommandType = CommandType.StoredProcedure;
        }
        #endregion

        #region 传递sql语句的参数(非查询)
        public static void SetCmdParameter(string parameterName, object parameterValue)
        {
            parameterName = "@" + parameterName.Trim();
            if (parameterValue == null)
                parameterValue = DBNull.Value;
            cmd.Parameters.Add(new SqlParameter(parameterName, parameterValue));         
        }
        public static void SetCmdReturnParameter(string parameterName)
        {
            parameterName = "@" + parameterName.Trim();
            SqlParameter pa = new SqlParameter();
            pa.ParameterName = parameterName;
            pa.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(pa);
        }

        public static object GetCmdParameter(string parameterName)
        {
            parameterName = "@" + parameterName.Trim();
            return cmd.Parameters[parameterName].Value;
        }
        #endregion

        #region 传递sql语句的参数(查询)
        public static void SetDataTableParameter(string parameterName, object parameterValue)
        {
            parameterName = "@" + parameterName.Trim();
            if (parameterValue == null)
                parameterValue = DBNull.Value;
            adp.SelectCommand.Parameters.Add(new SqlParameter(parameterName, parameterValue));
        }
        public static void SetDataTableReturnParameter(string parameterName)
        {
            parameterName = "@" + parameterName.Trim();
            SqlParameter pa = new SqlParameter();
            pa.ParameterName = parameterName;
            pa.Direction = ParameterDirection.ReturnValue;
            adp.SelectCommand.Parameters.Add(pa);
        }
        public static object GetDataTableParameter(string parameterName)
        {
            return adp.SelectCommand.Parameters["parameterName"].Value;
        }
        #endregion

        #region 执行非查询语句
        public static int ExecCmd()
        {
            int result = cmd.ExecuteNonQuery();
            conn.Close();
            return result;
        }
        #endregion

        #region 执行查询语句返回DataTable
        public static DataTable ExecDataTable()
        {
            DataTable dt = new DataTable();
            adp.Fill(dt);
            conn.Close();
            return dt;
        }
        #endregion

        #region 执行查询语句返回DataReader
        public static SqlDataReader ExecCmdDataReader()
        {
            return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }
        #endregion

        #region 执行一个查询的sql语句，返回第一行第一列的值
        public static object ExecCmdScalar()
        {
            object obj = cmd.ExecuteScalar();
            conn.Close();
            return obj;
        }
        #endregion


    }
}
