using System;
using System.Data.SqlClient;
using Activity7.Database;

class Program
{
    static void Main()
    {
        DatabaseConnection db = new DatabaseConnection();

        try
        {
            using (SqlConnection connection = db.GetConnection())
            {
                connection.Open();

                Console.WriteLine("Conexion exitosa a la base de datos.");

                string query = "SELECT CourseKey, Title FROM Courses";

                SqlCommand command = new SqlCommand(query, connection);

                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("\nLista de cursos:");

                while (reader.Read())
                {
                    Console.WriteLine($"{reader["CourseKey"]} - {reader["Title"]}");
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error:");
            Console.WriteLine(ex.Message);
        }

        Console.ReadKey();
    }
}