/*
First 
Load from Nuget
NetTopologySuite
ProjNet
*/

using System;
using NetTopologySuite;
using ProjNet;
using ProjNet.CoordinateSystems;
using ProjNet.CoordinateSystems.Transformations;
					
public class Program
{
	public static void Main()
	{

		//////Add this to class constructor
		NtsGeometryServices.Instance = new NtsGeometryServices(
		NetTopologySuite.Geometries.Implementation.CoordinateArraySequenceFactory.Instance,
		new NetTopologySuite.Geometries.PrecisionModel(1000d),4326,
		// Note the following arguments are only valid for NTS v2.2
		// Geometry overlay operation function set to use (Legacy or NG)
		NetTopologySuite.Geometries.GeometryOverlay.NG,
		// Coordinate equality comparer to use (CoordinateEqualityComparer or PerOrdinateEqualityComparer)
		new NetTopologySuite.Geometries.CoordinateEqualityComparer());
		
		//Add Geometry Extensions Class and
		
		
		// Use the following website to look up the arguement below that should match outputProjection ESRG
		//http://epsg.io
		var gf=NtsGeometryServices.Instance.CreateGeometryFactory(XXXX);
		//////End of Class Constructor
		
		var seattle = new Point(-122.333056, 47.609722) { SRID = 4326 };
		var redmond = new Point(-122.123889, 47.669444) { SRID = 4326 };

		// In order to get the distance in meters, we need to project to an appropriate
		// coordinate system. In this case, we're using SRID 2855 since it covers the
		// geographic area of our data
		var distanceInDegrees = seattle.Distance(redmond);
		var distanceInMeters = seattle.ProjectTo(2855).Distance(redmond.ProjectTo(2855));
		
	}

	//Add This class to an extensions folder
	internal static class GeometryExtensions
	{
		private static readonly CoordinateSystemServices _coordinateSystemServices
			= new CoordinateSystemServices(
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
					"
				});

		public static Geometry ProjectTo(this Geometry geometry, int srid)
		{
			var transformation = _coordinateSystemServices.CreateTransformation(geometry.SRID, srid);

			var result = geometry.Copy();
			result.Apply(new MathTransformFilter(transformation.MathTransform));

			return result;
		}

		private class MathTransformFilter : ICoordinateSequenceFilter
		{
			private readonly MathTransform _transform;

			public MathTransformFilter(MathTransform transform)
				=> _transform = transform;

			public bool Done => false;
			public bool GeometryChanged => true;

			public void Filter(CoordinateSequence seq, int i)
			{
				var x = seq.GetX(i);
				var y = seq.GetY(i);
				var z = seq.GetZ(i);
				_transform.Transform(ref x, ref y, ref z);
				seq.SetX(i, x);
				seq.SetY(i, y);
				seq.SetZ(i, z);
			}
		}
	}

}
