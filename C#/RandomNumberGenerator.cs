using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chap5Num7_1
/*  The purpose of this class is to generate random numbers
 *  1) RandomNumberGeneratordouble: This generate a random number list that are of type double given an exact length size
 *  2) RandomNumberGeneratorint: This generate a random number list that are of type double given an exact length size
 */
{
    public class RandomNumberGeneratordouble
    {
        //Generate random numbers given the data type int or double, a min and max value, and a list size.
        //The output is a list
        private List<double> _randomNumberList;
        private int _minimumValue;
        private int _maximumValue;
        private int _listSize;

        public List<double> randomNumberList
        {
            get { return _randomNumberList; }
            set { randomNumberList = value; }
        }

        public int minimumValue
        {
            get { return _minimumValue; }
            set { minimumValue = value; }
        }

        public int maximumValue
        {
            get { return _maximumValue; }
            set { maximumValue = value; }
        }

        public int listSize
        {
            get { return _listSize; }
            set { listSize = value; }
        }

        public List<double> GetRandomNumbers( int minimumValue, int maximumValue, int listSize)
        {
            Random numberListValues = new Random();

                    List<double> randomNumberList = new List<double>();
                    for (int i = 0; i < listSize; i++)
                    {
                        randomNumberList.Add(numberListValues.NextDouble() * (maximumValue - minimumValue) + minimumValue);
                    }

            return randomNumberList;
        }

    }

    public class RandomNumberGeneratorint
    {
        //Generate random numbers given the data type int or double, a min and max value, and a list size.
        //The output is a list
        private List<int> _randomNumberList;
        private int _minimumValue;
        private int _maximumValue;
        private int _listSize;

        public List<int> randomNumberList
        {
            get { return _randomNumberList; }
            set { randomNumberList = value; }
        }

        public int minimumValue
        {
            get { return _minimumValue; }
            set { minimumValue = value; }
        }

        public int maximumValue
        {
            get { return _maximumValue; }
            set { maximumValue = value; }
        }

        public int listSize
        {
            get { return _listSize; }
            set { listSize = value; }
        }

        public List<int> GetRandomNumbers(int minimumValue, int maximumValue, int listSize)
        {
            Random numberListValues = new Random();

            List<int> randomNumberList = new List<int>();
            for (int i = 0; i < listSize; i++)
            {
                randomNumberList.Add(numberListValues.Next(maximumValue - minimumValue) + minimumValue);
            }

            return randomNumberList;
        }

    }
}
