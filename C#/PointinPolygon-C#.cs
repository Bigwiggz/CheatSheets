using System;

/// <summary>
/// This class is to determine if an address:Lat/Long is located inside a territory:Polygon of points.  The inputs are 1) an array of polygon points and 2) the address point and the return
/// is true if the point is located inside the polygon and false if it is not.
/// </summary>
public class PointinPolygon
{


        public bool IsPointInPolygon(PointF[] polygon, PointF point)
        {
            bool isInside = false;
            for (int i = 0, j = polygon.Length - 1; i < polygon.Length; j = i++)
            {
                if (((polygon[i].Y > point.Y) != (polygon[j].Y > point.Y)) &&
                (point.X < (polygon[j].X - polygon[i].X) * (point.Y - polygon[i].Y) / (polygon[j].Y - polygon[i].Y) + polygon[i].X))
                {
                    isInside = !isInside;
                }
            }
            return isInside;
        }

}