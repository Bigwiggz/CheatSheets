/*
This is for use in a .Net Standard Library

Before doing anything, load the 2 following Nuget Packages
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
		
		//Transform Projection
		//*****Add ProjNet to make transform
		//https://docs.microsoft.com/en-us/ef/core/modeling/spatial
		
		//2nd Way
		
		//Add WKT projection coordinate system
		const string outputWKT=@"";
		CoordinateSystemFactory csFact = new CoordinateSystemFactory();
		var csWgs84Text=ProjNet.CoordinateSystems.GeographicCoordinateSystem.WGS84.WKT;
		var csWgs84=csFact.CreateFromWkt(csWgs84Text);
		var outputProjection=csFact.CreateFromWkt(outputWKT);
		CoordinateTransformationFactory ctFact = new CoordinateTransformationFactory();
		ICoordinateTransformation trans = ctFact.CreateFromCoordinateSystems(csWgs84, outputProjection);
		var mt=trans.MathTransform;
		
		
		// Use the following website to look up the arguement below that should match outputProjection ESRG
		//http://epsg.io
		var gf=NtsGeometryServices.Instance.CreateGeometryFactory(XXXX);
		//////End of Class Constructor
		
		//IMPORTANT-ALL GEOMETRY POINTS MUST BE WRAPPED WITH mt.Transform()
		// Create a point at Aurich (lat=53.4837, long=7.5404)
		var pntAUR = gf.CreatePoint(mt.Transform(new NetTopologySuite.Geometries.Coordinate(7.5404, 53.4837)));
		// Create a point at Emden (lat=53.3646, long=7.1559)
		var pntLER = gf.CreatePoint(mt.Transform(new NetTopologySuite.Geometries.Coordinate(7.1559, 53.3646)));
		// Create a point at Leer (lat=53.2476, long=7.4550)
		var pntEMD = gf.CreatePoint(mt.Transform(new NetTopologySuite.Geometries.Coordinate(7.4550, 53.2476)));
		
		var distancepntAURpntLER=pntAUR.Distance(pntLER);
		Console.WriteLine($"{distancepntAURpntLER} miles");
		
	}
}
