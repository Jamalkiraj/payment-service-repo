package main.java.com.example;

public class Main {
    public static void main(String[] args) {
        System.out.println("Starting the application...");

        // Create an instance of the AppService and call a method
        AppService appService = new AppService();
        appService.runService();

        System.out.println("Application finished.");
    }
}
