using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chap10Level0
{
    class MazeGenerator
    {
        //This is a console maze generator with a row/length input and  a proability of obstructions
        public string[,] GenerateMaze(int rowLength, int colLength, double probability)
        {
            //"S" is the start position and "E" is the end position
            Random obstructionGen = new Random();

            Random posGen = new Random();
            int startPos = posGen.Next(0,rowLength-1);
            int endPos = posGen.Next(0,rowLength-1);

            string[,] theMazeGen = new string[rowLength, colLength];

            for (int row=0;row<rowLength;row++)
            {
                for (int col=0;col<colLength;col++)
                {
                    //Random free space insert
                    Console.OutputEncoding = System.Text.Encoding.UTF8;
                    theMazeGen[row, col] = "\u25A1";
                    double myObstruction = obstructionGen.NextDouble();
                    if (myObstruction<=probability)
                    {
                        //Random obstruction insert
                        Console.ForegroundColor = ConsoleColor.Red;
                        theMazeGen[row, col] = "\u25A0";
                        Console.ResetColor();
                    }
                }
            }

            Console.ForegroundColor = ConsoleColor.Blue;
            theMazeGen[startPos, 0] = "S";
            theMazeGen[endPos, colLength-1] = "E";
            Console.ResetColor();

            ChangeTextColor startendText = new ChangeTextColor();

            //Print the array
            for (int row = 0; row < rowLength; row++)
            {
                for (int col = 0; col < colLength; col++)
                {
                    if(theMazeGen[row, col]== "S" || theMazeGen[row, col] == "E")
                    {
                        startendText.PrintColorMessage(ConsoleColor.Blue, theMazeGen[row, col]);
                    }
                    else if(theMazeGen[row, col] == "*")
                    {
                        startendText.PrintColorMessage(ConsoleColor.Red, theMazeGen[row, col]);
                    }
                    else
                    {
                        startendText.PrintColorMessage(ConsoleColor.White, theMazeGen[row, col]);
                    }
                }
                Console.WriteLine();
            }
            return theMazeGen;
        }
    }
}
