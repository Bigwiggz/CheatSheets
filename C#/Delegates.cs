//################################
DELEGATES
//################################

//SIMPLE Delegate
//################################

using System;  
  
namespace Delegates  
{  
    // Delegate Definition  
    public delegate int operation(int x, int y);  
         
    class Program  
    {  
        // Method that is passes as an Argument  
        // It has same signature as Delegates   
        static int Addition(int a, int b)  
        {  
            return a + b;  
        }  
  
        static void Main(string[] args)  
        {  
            // Delegate instantiation  
            operation obj = new operation(Program.Addition);  
   
            // output  
            Console.WriteLine("Addition is={0}",obj(23,27));   
            Console.ReadLine();    
        }  
    }  
}

//Array of delegates
//################################

using System;  
  
namespace Delegates  
{  
    public class Operation  
    {  
        public static void Add(int a, int b)  
        {  
            Console.WriteLine("Addition={0}",a + b);  
        }  
  
        public static void Multiple(int a, int b)  
        {  
            Console.WriteLine("Multiply={0}", a * b);  
        }  
    }   
  
    class Program  
    {  
        delegate void DelOp(int x, int y);  
  
        static void Main(string[] args)  
        {  
            // Delegate instantiation  
            DelOp[] obj =   
           {  
               new DelOp(Operation.Add),  
               new DelOp(Operation.Multiple)  
           };  
   
            for (int i = 0; i < obj.Length; i++)  
            {  
                obj[i](2, 5);  
                obj[i](8, 5);  
                obj[i](4, 6);  
            }  
            Console.ReadLine();  
        }  
    }  
}  

//Anonymous Methods
//################################


using System;  
  
namespace Delegates  
{  
    class Program  
    {  
        // Delegate Definition  
        delegate void operation();  
  
        static void Main(string[] args)  
        {  
            // Delegate instantiation  
            operation obj = delegate  
            {  
                Console.WriteLine("Anonymous method");  
            };  
            obj();  
   
            Console.ReadLine();  
        }  
    }  
}  

//MultiCast Delegate
//################################

using System;  
  
namespace Delegates  
{  
    public class Operation  
    {  
        public static void Add(int a)  
        {  
            Console.WriteLine("Addition={0}", a + 10);  
        }  
        public static void Square(int a)  
        {  
            Console.WriteLine("Multiple={0}",a * a);  
        }  
    }  
    class Program  
    {  
        delegate void DelOp(int x);  
   
        static void Main(string[] args)  
        {  
            // Delegate instantiation  
            DelOp obj = Operation.Add;  
            obj += Operation.Square;  
   
            obj(2);  
            obj(8);  
   
            Console.ReadLine();  
        }  
    }  
}  


//Events
//################################

using System;  
  
namespace Delegates  
{  
    public delegate void DelEventHandler();  
  
    class Program  
    {  
        public static event DelEventHandler add;  
   
        static void Main(string[] args)  
        {  
            add += new DelEventHandler(USA);  
            add += new DelEventHandler(India);  
            add += new DelEventHandler(England);  
            add.Invoke(); 
            
            //Remove event
            add-= DelEventHandler(USA);
   
            Console.ReadLine();  
        }  
        static void USA()  
        {  
            Console.WriteLine("USA");    
        }  
   
        static void India()  
        {  
            Console.WriteLine("India");  
        }  
   
        static void England()  
        {  
            Console.WriteLine("England");  
        }  
    }  
}  


