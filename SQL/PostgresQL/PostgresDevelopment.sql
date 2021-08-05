
-------------------------
--USING POSTGRESQL
-------------------------

-------------------------
--1 How to use geometry in Postgresql
-------------------------
CREATE EXTENSION postgis

-------------------------
--2 Use Address Standardizer
-------------------------
CREATE EXTENSION address_standardizer

-------------------------
--3 Use use TigerGeocoder
-------------------------
CREATE EXTENSION postgis;
CREATE EXTENSION fuzzystrmatch;
CREATE EXTENSION postgis_tiger_geocoder;
--this one is optional if you want to use the rules based standardizer ( ←-
pagc_normalize_address)
CREATE EXTENSION address_standardizer

-------------------------
--4 Using Dapper with POSTGRESQL
-------------------------
--1) Load basic Dapper in your data access library
--2) Use the following format for the Database connection string 
--"User ID=root;Password=myPassword;Host=localhost;Port=5432;Database=myDataBase;Pooling=true;Min Pool Size=0;Max Pool Size=100;Connection Lifetime=0;"
--3) Add Npgsql to your data access library
--4) Realize that PostgresQL uses functions as stored procedures
--5) Consider this example as a PostgresQL Insert using Dapper
--https://stackoverflow.com/questions/65186048/using-dapper-c-to-call-postgresql-stored-procedure
/*
-------------------------
--5a Npgsql USE
-------------------------
--WEBSITE https://www.npgsql.org/doc/basic-usage.html#stored-functions-and-procedures
Note that if CommandType.StoredProcedure is set and your parameter instances have names, 
Npgsql will generate parameters with named notation: SELECT my_func(p1 => 'some_value'). 
This means that your NpgsqlParameter names must match your PostgreSQL function parameters, 
or the function call will fail. If you omit the names on your NpgsqlParameters, 
positional notation will be used instead.

using (var cmd = new NpgsqlCommand("my_func", conn))
{
    cmd.CommandType = CommandType.StoredProcedure;
    cmd.Parameters.AddWithValue("p1", "some_value");
    using (var reader = cmd.ExecuteReader()) { ... }
}
*/

		/*
		//This is an example of an insert using Postgresql
		public static int? PO_Save(PurchaseOrder po)
			{

				int? recordId = null;           

				using (var cn = new NpgsqlConnection(AppSettings.ConnectionString))
				{
					if (cn.State != ConnectionState.Open)
						cn.Open();

					var procName = "CALL po_save(@in_ponumber,@in_deliverydate,@in_bldnum," +
						"@in_facname,@in_facnumber,@in_facaddress1,@in_facaddress2,@in_city," +
						"@in_state,@in_zip,@in_theme,@id_inout)";
					var p = new Dapper.DynamicParameters();
					p.Add("@in_ponumber", po.PONumber);
					p.Add("@in_deliverydate", po.DeliveryDate);
					p.Add("@in_bldnum", po.BldNum);
					p.Add("@in_facname", po.FacName);
					p.Add("@in_facnumber", po.FacNumber);
					p.Add("@in_facaddress1", po.FacAddress1);
					p.Add("@in_facaddress2", po.FacAddress2);
					p.Add("@in_city", po.City);
					p.Add("@in_state", po.State);
					p.Add("@in_zip", po.Zip);
					p.Add("@in_theme", po.Theme);
					p.Add("@id_out", po.POID, null, ParameterDirection.InputOutput);
					var res = cn.Execute(procName, p);
					recordId = p.Get<int>("@id_inout");
				}

				return recordId;
			}
		*/
--6) https://www.npgsql.org/doc/basic-usage.html#stored-functions-and-procedures



