class Logger {
    private static final Logger instance = new Logger();

    private Logger() {
    }

    public static Logger getInstance() {
        return instance;
    }

    public void log(String message) {
        System.out.println("[LOG] " + message);
    }
}

public class LoggerTest {
    public static void main(String[] args) {
        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();

        logger1.log("Application started");
        logger2.log("Second reference logging");

        System.out.println("Same instance? " + (logger1 == logger2));
    }
}