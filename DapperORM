/*
DAPPER WITH C#
*/

//(1)FOR DAPPER TO WORK, YOUR C# CLASS PROPERTIES NEED TO HAVE THE SAME NAME AS THE TABLE NAMES
//(2)FOR REGULAR DAPPER, USE .QUERYFIRST FOR ONE RECORD, .QUERY FOR MORE THAN ONE RECORD AND .EXECUTE TO UPDATE, WRITE AND DELETE
//(3)FOR DAPPER.CONTRIB TO WORK, THE CLASS NAME NEEDS TO BE THE SAME AS THE DB TABLE NAME.

//######################################################################
//Dapper Query Basics
//######################################################################
static void Main(string[] args)
{
	var connectionString="Data Source=(local);Initial Catalog=DapperExample;Integrated Security=SSPI";
	using (SqlConnection connection=new SqlConnection(connectionString))
	{
		//Do you DAPPER Here
	}
}

//##
//Dapper Query A Single Row
//###################################
using (SqlConnection connection=new SqlConnection(connectionString))
	{
		var eventName=connection.QueryFirst<string>("SELECT TOP 1 EventName FROM Event WHERE Id=1");
		//Use Dapper Query Result Here
		Console.WriteLine(eventName);
		Console.ReadLine();
	}

//##
//Dapper Query A Table Into An Object
//###################################

//This is our object class "Event"

class Event
{
	public int Id {get; set;}
	public int EventLocationId {get; set;}
	public string EventName {get; set;}
	public DateTime EventDate {get; set;}
}

//This is our Dapper Object Mapping
//USE .QUERYFIRST TO RETURN ONE ITEM
using (SqlConnection connection=new SqlConnection(connectionString))
	{
		var myEvent=connection.QueryFirst<string>("SELECT * FROM Event WHERE Id=1");
		//Use Dapper Query Result Here
		Console.WriteLine(myEvent.Id +":"+ myEvent.EventName);
		Console.ReadLine();
	}


//##
//Dapper Statement Into a DTO
//###################################


//This is our DTO EventDto

class EventDto
{
	public int Id {get;set;}
	public string EventName {get;set;}
}

//This is our Dapper Object Mapping
//USE .QUERYFIRST TO RETURN ONE ITEM
using (SqlConnection connection=new SqlConnection(connectionString))
	{
		var myEvent=connection.QueryFirst<string>("SELECT Id,EventName FROM Event WHERE Id=1");
		//Use Dapper Query Result Here
		Console.WriteLine(myEvent.Id +":"+ myEvent.EventName);
		Console.ReadLine();
	}

//##
//Dapper Parameterized Queries
//###################################

//USE .QUERYFIRST TO RETURN ONE ITEM
using (SqlConnection connection=new SqlConnection(connectionString))
	{
		int eventId=1;
		var myEvent=connection.QueryFirst<string>("SELECT Id,EventName FROM Event WHERE Id=@Id",new{Id=eventId});
		//Use Dapper Query Result Here
		Console.WriteLine(myEvent.Id +":"+ myEvent.EventName);
		Console.ReadLine();
	}
	
//##
//Dapper Query Multiple Rows
//###################################


//USE .QUERY TO RETURN A LIST
using (SqlConnection connection=new SqlConnection(connectionString))
	{
		var allEvents=connection.Query<string>("SELECT Id,EventName FROM Event");
		//Use Dapper Query Result Here
		//Dapper returns a list
		foreach(var myEvent in allEvents)
		{
			Console.WriteLine(myEvent.Id+":"+ myEvent.EventName);
		}
		Console.ReadLine();
	}
	
//######################################################################
//Dapper.Contrib
//######################################################################

//To install the packaged on the NewGet Package Manager Console run "Install-Package Dapper.Contrib"

//##
//Dapper.Contrib Model C# class for writes
//###################################

//Need to add [Key] attribute to class model for Dapper.Contrib to work
//Need to add the table name attribute at the top of the class
[Table ("Event")]
class Event
{
	[Key]
	public int Id {get; set}
	public int EventLocationId {get; set}
	public string EventName {get; set}
	public DateTime EventDate {get; set}
	public DateTime DateCreated {get; set}
}

//##
//INSERT Records using Dapper.Contrib
//###################################
using (SqlConnection connection=new SqlConnection(connectionString))
	{
		var newEvent= new Event
		{
			EventLocationId=1,
			EventName="Contrib Inserted Event",
			EventDate=DateTime.Now.AddDays(1),
			DateCreated=DateTime.UtcNow
		};
		connection.Insert(newEvent);
	}

//##
//QUERY A Record using Dapper.Contrib
//###################################
using (SqlConnection connection=new SqlConnection(connectionString))
	{
		var eventId=1;
		var myEvent=connection.Get<Event>(eventId);
	}
	
//##
//UPDATE A Record using Dapper.Contrib
//###################################
using (SqlConnection connection=new SqlConnection(connectionString))
	{
		var eventId=1;
		var myEvent=connection.Get<Event>(eventId);
		myEvent.EventName="New Event Name";
		connection.Update(myEvent);
	}
	
//##
//DELETE A Record using Dapper.Contrib
//###################################
using (SqlConnection connection=new SqlConnection(connectionString))
	{
		connection.Delete<Event>(eventId);
	}

OTHER Dapper.Contrib Attributes



//######################################################################
//Dapper Updating Basics
//######################################################################



//##
//Dapper UPDATE
//###################################

//USE .EXECUTE TO UPDATE
using (SqlConnection connection=new SqlConnection(connectionString))
	{
		
		connection.Execute<string>("UPDATE Event SET EventName="NewEventName" WHERE Id=1");
		//Use Dapper Query Result Here
		//Dapper returns a list
	}

//##
//Dapper UPDATE WITH PARAMETERS
//###################################

//USE .EXECUTE TO UPDATE
using (SqlConnection connection=new SqlConnection(connectionString))
	{
		var eventId=1;
		var eventName="NewEventName";
		connection.Execute<string>("UPDATE Event SET EventName=@EventName WHERE Id=@EventId",new{EventName=eventName,EventId=eventId});

	}
	

//##
//Dapper INSERTING A RECORD
//###################################

//USE .EXECUTE TO INSERT
using (SqlConnection connection=new SqlConnection(connectionString))
	{
		var eventId=1;
		var eventName="NewEventName";
		connection.Execute<string>("INSERT INTO Event (EventLocationId, EventName, EventDate, DateCreated) VALUES(1, 'InsertedEvent', '2019-01-01', GETUTCDATE())");
		
	}
	
//##
//Dapper DELETE A RECORD
//###################################

//USE .EXECUTE TO DELETE
using (SqlConnection connection=new SqlConnection(connectionString))
	{
		connection.Execute<string>("DELETE FROM Event WHERE Id=4");
		//Use Dapper Query Result Here

	}


//######################################################################
//Dapper Using Transactions
//######################################################################

public void UpdateWidgetQuantity(int widgetId, int quantity)
{
    using(var conn = new SqlConnection("{connection string}")) {
        conn.Open();

        // create the transaction
        // You could use `var` instead of `SqlTransaction`
        using(SqlTransaction tran = conn.BeginTransaction()) {
            try
            {
                var sql = "update Widget set Quantity = @quantity where WidgetId = @id";
                var parameters = new { id = widgetId, quantity };

                // pass the transaction along to the Query, Execute, or the related Async methods.
                conn.Execute(sql, parameters, tran);

                // if it was successful, commit the transaction
                tran.Commit();
            }
            catch(Exception ex)
            {
                // roll the transaction back
                tran.Rollback();

                // handle the error however you need to.
                throw;
            }
        }
    }   
}


//######################################################################
//Dapper Bulk Insert, Update Delete Data
//######################################################################



using (var connection = new SQLiteConnection(connString))
{
    var newCategories = new[]{
        new {CategoryName = "New Category 1", Description = "Description 1"},
        new {CategoryName = "New Category 2", Description = "Description 2"},
        new {CategoryName = "New Category 3", Description = "Description 3"},
        new {CategoryName = "New Category 4", Description = "Description 4"},
    };
	var sql = "insert into categories (CategoryName, Description) values (@CategoryName, @Description)";
    var affectedRows =  connection.Execute(sql, newCategories);
    Console.WriteLine($"Affected Rows: {affectedRows}");
}
