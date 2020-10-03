
/*
FIRST IMPORT 
Microsoft.SqlServer.Types.SqlGeography
*/

//Point in Polygon Method using SQL Server Data Types

private bool OneOffSTIntersect()
{
    var g =
        Microsoft.SqlServer.Types.SqlGeography.STGeomFromText(
            new System.Data.SqlTypes.SqlChars(
                "POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))"), 4326);
    // suffix "d" on literals below optional but explicit
    var h = Microsoft.SqlServer.Types.SqlGeography.Point(47.653d, -122.358d, 4326);

    // rough equivalent to SELECT
    System.Console.WriteLine(g.STIntersects(h));

    // Alternatively return from a C# method or property (get).
    return g.STIntersects(h);
}


//Get Surface area
private double Area()
{
	double Area=Microsoft.SqlServer.Types.SqlGeography.STArea(
	new System.Data.SqlTypes.SqlChars(
                "POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))"), 4326);
	);
	//Change Units if Necessary
	
	return Area;
}

//Get perimeter of a shape
private double Perimeter()
{
	double Perimeter=Microsoft.SqlServer.Types.SqlGeography.STArea(
	new System.Data.SqlTypes.SqlChars(
                "POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))"), 4326);
	);
	//Change Units if Necessary
	
	return Perimeter;
}

//A system that halfway works

//1) download NetTopologySuite from NuGet
using System;
using NetTopologySuite.Geometries;

public class Program
{
	public static void Main()
	{
		// Create a 2D GeographyPoint.  This point is INSIDE of the polygon
		Point point1 = new Point(-81.07700840609681, 33.99243234914476);
		
		//Create a 2D GeographyPoint.  This point is OUTSIDE of the polygon
		Point point2 = new Point(-81.07342456871636, 33.99336391399117);
		
		//Find the distance between the 2 points
		var distance=point1.Distance(point2);
		
		//Create Polygon
		Polygon testShape= new Polygon(new LinearRing(new Coordinate[]
			{
				new Coordinate(-81.07714190075039,33.99300447487767),
				new Coordinate(-81.07705976188026,33.99287858806552),
				new Coordinate(-81.07752576194196,33.99276912848259),
				new Coordinate(-81.07807704574228,33.9929092117429),
				new Coordinate(-81.07754088190489,33.99163588058775),
				new Coordinate(-81.0756370128266,33.99227359382828),
				new Coordinate(-81.07621172918024,33.99335737448596),
				new Coordinate(-81.07714190075039,33.99300447487767)
			}));
		//Determine Area of Polygon
		var polygonArea=testShape.Area;
		
		//Determine Perimeter Length of Polygon
		var polygonPerimeterLength=testShape.Length;
		
		//Find
		bool isInside(Polygon shape, Point location)
		{
			bool isThisInside=shape.Contains(location);
			return isThisInside;
		}
		
		//Point in Polygon Method
		Console.WriteLine($"Area of Territory:{polygonArea}");
		Console.WriteLine($"Perimeter of Territory:{polygonPerimeterLength}");
		Console.WriteLine($"Distance Between 2 points:{distance}");
		Console.WriteLine($"Point {point1} is inside testShape:{isInside(testShape,point1)}");
		Console.WriteLine($"Point {point2} is inside testShape:{isInside(testShape,point2)}");
	}
}


//Sqlgeography method
using System;
using Microsoft.SqlServer.Types;

namespace trial
{
	public class Program
	{
		public static void Main()
		{
			//SRID
			int SRID=4326;

			// Create a 2D GeographyPoint.  This point is INSIDE of the polygon
			var point1=SqlGeography.Point(-81.07700840609681, 33.99243234914476,SRID);

			//Create a 2D GeographyPoint.  This point is OUTSIDE of the polygon
			var point2=SqlGeography.Point(-81.07342456871636, 33.99336391399117,SRID);

			//Find the distance between the 2 points
			//var distance=point1.STDistance(point2);

			//Create Polygon
			var testShape=SqlGeography.STPolyFromText(
				new System.Data.SqlTypes.SqlChars(@"POLYGON((
												  -81.07714190075039,33.99300447487767,
												  -81.07705976188026,33.99287858806552,
												  -81.07752576194196,33.99276912848259,
												  -81.07807704574228,33.9929092117429,
												  -81.07754088190489,33.99163588058775,
												  -81.0756370128266,33.99227359382828,
												  -81.07621172918024,33.99335737448596,
												  -81.07714190075039,33.99300447487767
												 ))"),SRID);

			//Determine Area of Polygon
			var polygonArea=testShape.STArea();

			//Determine Perimeter Length of Polygon
			var polygonPerimeterLength=testShape.STLength();
			/*
			//Find
			bool isInside(SqlGeography shape, SqlGeography location)
			{
				var isThisInside=shape.STContains(location);
				return true;
			}
			*/
			//Point in Polygon Method
			Console.WriteLine("Area of Territory");
			/*
			Console.WriteLine($"Perimeter of Territory:{polygonPerimeterLength}");
			Console.WriteLine($"Distance Between 2 points:{distance}");
			Console.WriteLine($"Point {point1} is inside testShape:{isInside(testShape,point1)}");
			Console.WriteLine($"Point {point2} is inside testShape:{isInside(testShape,point2)}");
			*/
		}
	}
}

//To transform data coordinates
https://github.com/NetTopologySuite/ProjNet4GeoAPI/wiki/Projecting-points-from-one-coordinate-system-to-another

//WGS1984

PROJCS["Mercator Spheric", GEOGCS["WGS84based_GCS", DATUM["WGS84based_Datum", SPHEROID["WGS84based_Sphere", 6378137, 0], TOWGS84[0, 0, 0, 0, 0, 0, 0]], PRIMEM["Greenwich", 0, AUTHORITY["EPSG", "8901"]], UNIT["degree", 0.0174532925199433, AUTHORITY["EPSG", "9102"]], AXIS["E", EAST], AXIS["N", NORTH]], PROJECTION["Mercator"], PARAMETER["False_Easting", 0], PARAMETER["False_Northing", 0], PARAMETER["Central_Meridian", 0], PARAMETER["Latitude_of_origin", 0], UNIT["metre", 1, AUTHORITY["EPSG", "9001"]], AXIS["East", EAST], AXIS["North", NORTH]]