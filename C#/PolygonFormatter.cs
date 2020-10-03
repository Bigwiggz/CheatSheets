
/*
	Input Format as String
	POLY:(33.91729659075691, -81.1956519902344),(33.855735049679616, -81.0802955449219),(33.82721929601059, -81.18741224414065)

	Formatting
	1) Must reverse lat long to long lat
	2) Must repeat first point at end
	3) Must remove commas so that they are only between points 

	Output Format as String
	'POLYGON((-81.1956519902344 33.91729659075691, -81.0802955449219 33.855735049679616, -81.18741224414065 33.82721929601059, -81.1956519902344 33.91729659075691))'
	*/
	
		static string GeographyPolygonStringFormatterFromGoogleMapsToSQLString(string inputString)
		{
			//Step 1 Remove beginning first 5 characaters
			inputString=inputString.Remove(0,5);
			//Step 2 remove all parenthesis
			inputString=inputString.Replace("("," ");
			inputString=inputString.Replace(")","");
			//Step 3 coma seperate values and load in a list
			string[] individualCoords=inputString.Split(',');
			//Count number of coordinates
			int countofCoords=(inputString.Count(x => x == ',')+1)/2;
			
			foreach (var coord in individualCoords)
			{
				Console.WriteLine($"{coord}");
			}
			string temp;
			for (int j = 1; j < individualCoords.Length; j += 2) 
			{
				temp = individualCoords[j-1];
				individualCoords[j-1] = individualCoords[j];
				individualCoords[j] = temp;
			}
			string interiorString=String.Join(",", individualCoords);
			// Get rid of every other comma
			
			//Remove space after first set of parenthesises
			
			
			//Repeat first set of coordinates at end of string
			string addEndpoint=$", {individualCoords[0]} {individualCoords[1]}";
			string startString="POLYGON((";
			string endString="))";
			string outputString=$"{startString}{interiorString}{endString}";
			Console.WriteLine($"String Coordinates:{outputString}");
			return outputString;
		}
			

