using System;
using NetTopologySuite;
using NetTopologySuite.Geometries;
using GeoAPI.Geometries;
using ProjNet;
using ProjNet.CoordinateSystems;
using ProjNet.CoordinateSystems.Transformations;
using System.Collections.Generic;


public class Program
{
	public static void Main()
	{
		//Create Geometry Factory
		var geometryFactory=NtsGeometryServices.Instance.CreateGeometryFactory(srid: 4326);
			
		//Point 1	
		var pointLocation1 = geometryFactory.CreatePoint(new Coordinate(-122.121512, 47.6739882,0));
		//Project to Other Coordinate System
		pointLocation1.ProjectTo(4326,3857);
		//Point 2
		var pointLocation2 = geometryFactory.CreatePoint(new Coordinate(-122.333056, 47.609722,0));
		pointLocation2.ProjectTo(4326,3857);
		
		
		//Get the distance between 2 points
		var distance=pointLocation1.Distance(pointLocation2);
		
		
		//PointsList for Polygon
			Array coordinateArray=new Coordinate[] 
			{
				new Coordinate(-81.07714190075039,33.99300447487767),
				new Coordinate(-81.07705976188026,33.99287858806552),
				new Coordinate(-81.07752576194196,33.99276912848259),
				new Coordinate(-81.07807704574228,33.9929092117429),
				new Coordinate(-81.07754088190489,33.99163588058775),
				new Coordinate(-81.0756370128266,33.99227359382828),
				new Coordinate(-81.07621172918024,33.99335737448596),
				new Coordinate(-81.07714190075039,33.99300447487767)
			};
		
		//Project to Other Coordinate System
		var cordList=new LinearRing((Coordinate[])coordinateArray).ProjectTo(4326,3857);
		
		//Area of shape
		var shapeArea=Math.Round(cordList.Area,3);
		var type=cordList.GetType();
		
		//Perimeter Length
		var shapePerimeter=Math.Round(cordList.Length,3);
		
		//Draw Polygon
		var testShape = geometryFactory.CreatePolygon(new LinearRing((Coordinate[])coordinateArray));
		//Project to Other Coordinate System
		testShape.ProjectTo(4326,3857);
		var testShapeArea=Math.Round(testShape.Area,3);
		var polygonType=testShape.GetType();
		var linearRingType=new LinearRing((Coordinate[])coordinateArray).GetType();
		
		
		//Console Information
		Console.WriteLine("------------------------------------------------------------------");
		Console.WriteLine($"--<NETTOPOLOGYSUITE TEST>--");
		Console.WriteLine($"DISTANCE BETWEEN 2 POINTS: {distance} meters");
		Console.WriteLine($"CORDLIST AREA:             {shapeArea} meters squared");
		Console.WriteLine($"TESTSHAPE AREA:            {testShapeArea} meters squared");
		Console.WriteLine($"CORDLIST TYPE:             {type}");
		Console.WriteLine($"LINEAR RING TYPE:          {linearRingType}");
		Console.WriteLine($"POLYGON TYPE:              {polygonType}");
		Console.WriteLine($"PERIMETER LENGTH:          {shapePerimeter} meters");
		Console.WriteLine("------------------------------------------------------------------");
	}
}

public static class GeometryExtentions
    {
		static readonly CoordinateSystemServices _coordinateSystemServices
        = new CoordinateSystemServices(
            new CoordinateSystemFactory(),
            new CoordinateTransformationFactory(),
            new Dictionary<int, string>
            {
                // Coordinate systems:

                [4326] = GeographicCoordinateSystem.WGS84.WKT,

                // This coordinate system covers the area of our data.
                // Different data requires a different coordinate system.
                [2855] =
                @"
                    PROJCS[""NAD83(HARN) / Washington North"",
                        GEOGCS[""NAD83(HARN)"",
                            DATUM[""NAD83_High_Accuracy_Regional_Network"",
                                SPHEROID[""GRS 1980"",6378137,298.257222101,
                                    AUTHORITY[""EPSG"",""7019""]],
                                AUTHORITY[""EPSG"",""6152""]],
                            PRIMEM[""Greenwich"",0,
                                AUTHORITY[""EPSG"",""8901""]],
                            UNIT[""degree"",0.01745329251994328,
                                AUTHORITY[""EPSG"",""9122""]],
                            AUTHORITY[""EPSG"",""4152""]],
                        PROJECTION[""Lambert_Conformal_Conic_2SP""],
                        PARAMETER[""standard_parallel_1"",48.73333333333333],
                        PARAMETER[""standard_parallel_2"",47.5],
                        PARAMETER[""latitude_of_origin"",47],
                        PARAMETER[""central_meridian"",-120.8333333333333],
                        PARAMETER[""false_easting"",500000],
                        PARAMETER[""false_northing"",0],
                        UNIT[""metre"",1,
                            AUTHORITY[""EPSG"",""9001""]],
                        AUTHORITY[""EPSG"",""2855""]]
                ",

                [3857]="PROJCS[\"WGS 84 / World Mercator\",GEOGCS[\"WGS 84 sphere\",DATUM[\"WGS_1984 sphere\",SPHEROID[\"WGS 84 sphere\",6378137,0.0]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],UNIT[\"degree\",0.01745329251994328,AUTHORITY[\"EPSG\",\"9122\"]]],PROJECTION[\"Mercator_1SP\"],PARAMETER[\"latitude_of_origin\",0],PARAMETER[\"central_meridian\",0],PARAMETER[\"scale_factor\",1],PARAMETER[\"false_easting\",0],PARAMETER[\"false_northing\",0],UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Northing\",NORTH]]"

            });
		public static Geometry ProjectTo(this Geometry geometry, int Oldsrid, int Newsrid)
        {
            var transformation = _coordinateSystemServices.CreateTransformation(Oldsrid, Newsrid);

            var result = geometry.Copy();
            result.Apply(new MathTransformFilter((MathTransform)transformation.MathTransform));

            return (Geometry)result;
        }
	
		public static Geometry ProjectTo(this IGeometry geometry, int Oldsrid, int Newsrid)
        {
            var transformation = _coordinateSystemServices.CreateTransformation(Oldsrid, Newsrid);

            var result = geometry.Copy();
            result.Apply(new MathTransformFilter((MathTransform)transformation.MathTransform));

            return (Geometry)result;
        }
		
		class MathTransformFilter : ICoordinateSequenceFilter
        {
            readonly MathTransform _transform;

            public MathTransformFilter(MathTransform transform)
                => _transform = transform;

            public bool Done => false;
            public bool GeometryChanged => true;

            public void Filter(ICoordinateSequence seq, int i)
            {
                var result = _transform.Transform(
                    new[]
                    {
                    seq.GetOrdinate(i, Ordinate.X),
                    seq.GetOrdinate(i, Ordinate.Y)
                    });
                seq.SetOrdinate(i, Ordinate.X, result[0]);
                seq.SetOrdinate(i, Ordinate.Y, result[1]);
            }
        }
	}
	
	//Sql Server Convert Text to SQLGeography Type
	
	declare @gt nvarchar(max)
declare @gm geometry
declare @gmvalid geometry

set @gmvalid = @gm.MakeValid()

  set @gt = @gmvalid.STAsText()

  --select @gt
  if LEFT(@gt,7 ) = 'POLYGON'
  begin
  set @gg = geography::STPolyFromText(@gt, 4326)
  end
  else
  begin
  set @gg = geography::STMPolyFromText(@gt, 4326)
  end